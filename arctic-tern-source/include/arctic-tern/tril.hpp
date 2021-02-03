/** Trilean
 * Version: 1.0
 *
 * Primitive trilean data type (tril).
 *
 * Author(s): Jason C. McDonald
 */

/* LICENSE (BSD-3-Clause)
 * Copyright (c) 2016-2021 MousePaw Media.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software without
 * specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 *
 * CONTRIBUTING
 * See https://www.mousepawmedia.com/developers for information
 * on how to contribute to our projects.
 */

#ifndef ARCTICTERN_UNCERTAINTY_HPP
#define ARCTICTERN_UNCERTAINTY_HPP

#include "arctic-tern/uncertainty.hpp"

class tril {
protected:
  /** The actual binary data. By using an int8_t, we are ensuring
   * that a tril is never larger than one byte. */
  int8_t data;

  /* These constants allow us to quickly check the three flags in
   * our data byte. Simply use "data & FLAG", where FLAG is one of the
   * following. */
  static const int8_t B = (1 << 0);
  static const int8_t U = (1 << 1);

  /* We are employing the Safe Bool Idiom. */
  typedef void (tril::*bool_type)() const noexcept;
  void this_type_does_not_support_some_comparisons() const noexcept {}

  /** Set the B (boolean) bit.
   * \param the new value for the boolean bit. */
  void set_b(bool b) noexcept { data = (b ? (data | B) : (data & ~B)); }

  /** Set the U (uncertainty) bit.
   * \param the new value for the uncertainty bit. */
  void set_u(bool u) noexcept { data = (u ? (data | U) : (data & ~U)); }

public:
  /** Construct a new trilean with a default value of certain false. */
  tril() noexcept : data(0) {}

  /** Construct a new trilean with the specified flag values.
   * \param the boolean bit (true/false)
   * \param the uncertainty bit */
  tril(bool in_b, bool in_u = false) noexcept : data(0) {
    set_b(in_b);
    set_u(in_u);
  }

  /** Trilean copy constructor.
   * \param the trilean to copy */
  tril(const tril &in) noexcept : data(in.data) {}

  /** Construct a new trilean with an uncertainty variable.
   * \param the uncertainty to copy */
  // cppcheck-suppress noExplicitConstructor
  tril(const uncertainty &in) noexcept : data(0) { set_u(in.data); }

  /** Return last certain state of the trilean. Does not modify
   * the trilean itself.
   * \return the last certain state */
  bool certain() const noexcept {
    // Return the boolean bit, ignoring the uncertainty bit.
    return (data & tril::B);
  }

  /** Boolean cast, following the Safe Bool Idiom.
   * Returns TRUE if the trilean is CERTAIN TRUE. */
  operator bool_type() const noexcept {
    if (~(*this)) {
      return 0;
    } else {
      return (!!(*this)) ? &tril::this_type_does_not_support_some_comparisons
                         : 0;
    }
  }

  /** Returns TRUE if the trilean is CERTAIN FALSE. */
  friend bool operator!(const tril &rhs) noexcept {
    // Get the boolean bit of rhs.
    bool b = (rhs.data & tril::B);
    // Get the uncertainty bit of rhs.
    bool u = (rhs.data & tril::U);

    /* If uncertain, return false. Otherwise, return inverse (NOT) of
     * the boolean flag. */
    return (u ? false : !b);
  }

  /** Returns TRUE if the trilean is MAYBE. */
  friend bool operator~(const tril &rhs) noexcept {
    // Return just the uncertainty bit of rhs.
    return (rhs.data & tril::U);
  }

  /** Assign a boolean (true/false) to this trilean. */
  tril &operator=(const bool &rhs) noexcept {
    set_b(rhs);
    set_u(false);
    return *this;
  }

  /** Assign a trilean (true/false/maybe) to this trilean. */
  tril &operator=(const tril &rhs) noexcept {
    // We just copy all the data from one tril to the other.
    data = rhs.data;

    return *this;
  }

  /** Assign an uncertainty to this trilean, only modifying the
   * uncertainty bit without modifying the boolean bit. */
  tril &operator=(const uncertainty &rhs) noexcept {
    /* We only copy the uncertainty state, so as to preserve the
     * boolean bit and allow reverting with `certain()`. */
    set_u(rhs.data);

    return *this;
  }

  /* Valid comparisons. All unspecified comparisons trigger compiler
   * errors, thanks to the Safe Bool Idiom. */
  friend bool operator==(const tril &lhs, const bool &rhs) noexcept {
    // Get the boolean bit of the left side.
    bool b = (lhs.data & tril::B);
    // Get the uncertainty bit of the right side.
    bool u = (lhs.data & tril::U);

    // If uncertain, return FALSE. Else, return whether boolean values match.
    return (u ? false : rhs == b);
  }

  friend bool operator==(const bool &lhs, const tril &rhs) noexcept {
    // We'll use operator!=(tril, bool), since the logic is the same.
    return (rhs == lhs);
  }

  friend bool operator==(const tril &lhs, const tril &rhs) noexcept {
    // Get the boolean bit of the left side.
    bool lb = (lhs.data & tril::B);
    // Get the uncertainty bit of the left side.
    bool lu = (lhs.data & tril::U);

    // Get the boolean bit of the right side.
    bool rb = (rhs.data & tril::B);
    // Get the uncertainty bit of the right side.
    bool ru = (rhs.data & tril::U);

    /* Return TRUE if both are uncertain
     * OR if they are both certain and have same boolean value. */
    return ((lu && ru) || (!lu && !ru && lb == rb));
  }

  friend bool operator==(const tril &lhs, const uncertainty &rhs) noexcept {
    /* When comparing a tril and a pure tril, the boolean bit is irrelevant.
     * Only the uncertainty flag matters in a pure tril. */

    // Get the uncertainty bit of the left side.
    bool u = (lhs.data & tril::U);

    // Return TRUE if both certainty flags match.
    return (u == rhs.data);
  }

  friend bool operator!=(const tril &lhs, const bool &rhs) noexcept {
    // Get the boolean bit of the left side.
    bool b = (lhs.data & tril::B);
    // Get the uncertainty bit of the right side.
    bool u = (lhs.data & tril::U);

    // If uncertain, return FALSE. Else, return whether boolean values
    // match.
    return (u ? true : rhs != b);
  }

  friend bool operator!=(const bool &lhs, const tril &rhs) noexcept {
    // We'll use operator!=(tril, bool), since the logic is the same.
    return (rhs != lhs);
  }

  friend bool operator!=(const tril &lhs, const tril &rhs) noexcept {
    // Get the boolean bit of the left side.
    bool lb = (lhs.data & tril::B);
    // Get the uncertainty bit of the left side.
    bool lu = (lhs.data & tril::U);

    // Get the boolean bit of the right side.
    bool rb = (rhs.data & tril::B);

    // Get the uncertainty bit of the right side.
    bool ru = (rhs.data & tril::U);

    /* If one (not both) is uncertain
     * OR if they're both certain and the boolean types don't match. */
    return ((lu && !ru) || (!lu && ru) || (!lu && !ru && lb != rb));
  }

  friend bool operator!=(const tril &lhs, const uncertainty &rhs) noexcept {
    /* When comparing a tril and a pure tril, the boolean bit is irrelevant.
     * Only the uncertainty flag matters in a pure tril. */

    // Get the uncertainty bit of the left side.
    bool u = (lhs.data & tril::U);

    // Return FALSE if both certainty flags match.
    return (u != rhs.data);
  }

  friend std::ostream &operator<<(std::ostream &output, const tril &in) {
    // Get the boolean bit of the trilean.
    bool b = (in.data & tril::B);
    // Get the uncertainty bit of the trilean.
    bool u = (in.data & tril::U);

    /* If uncertain, we'll pass the number "2". Otherwise, we can just
     * pass the boolean bit, and "0" will be shown for false, and "1" for
     * true, as with all booleans. */
    output << (u ? 2 : b);
    return output;
  }

  ~tril() = default;
};

#endif
