/** Uncertainty
 * Version: 1.0
 *
 * Immutable representation of uncertainty, as a component of tril.
 * (Not intended to be used directly.)
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

class tril;

/* The uncertainty class is never intended to be modified after creation.
 * It is used to represent a "pure maybe" - a trilean with no valid boolean
 * value. The constant "maybe" is an instance of this class. Initializing
 * or assigning a tril with an uncertainty does not affect the tril's
 * boolean value. */
class uncertainty {
  /* tril has to be able to access protected data of
   * uncertainty instances. */
  friend class tril;

protected:
  bool data;

public:
  /** Construct an uncertainty.
   * \param the initial value (default true) */
  explicit uncertainty(bool u = true) noexcept : data(u) {}

  /** Returns TRUE if the certainty is MAYBE. */
  friend bool operator~(const uncertainty &rhs) noexcept {
    // Return the certainty of rhs.
    return (rhs.data);
  }

  friend bool operator==(const uncertainty &lhs,
                         const uncertainty &rhs) noexcept {
    return (lhs.data == rhs.data);
  }

  friend bool operator!=(const uncertainty &lhs,
                         const uncertainty &rhs) noexcept {
    return !(lhs == rhs);
  }

  friend bool operator==(const uncertainty &, const bool &) noexcept {
    return false;
  }

  friend bool operator!=(const uncertainty &, const bool &) noexcept {
    return false;
  }

  friend bool operator==(const bool &lhs, const uncertainty &rhs) noexcept {
    return (rhs == lhs);
  }

  friend bool operator!=(const bool &lhs, const uncertainty &rhs) noexcept {
    return !(rhs == lhs);
  }

  /* We see these again in the `tril` class. We're repeating the
   * declaration here to ensure these functions are friends of
   * BOTH classes. */
  friend bool operator==(const tril &, const uncertainty &) noexcept;
  friend bool operator!=(const tril &, const uncertainty &) noexcept;

  friend bool operator==(const uncertainty &lhs, const tril &rhs) noexcept {
    return (rhs == lhs);
  }

  friend bool operator!=(const uncertainty &lhs, const tril &rhs) noexcept {
    return (rhs != lhs);
  }

  friend std::ostream &operator<<(std::ostream &output, const uncertainty &in) {
    output << (in.data ? "Uncertain" : "Certain");
    return output;
  }

  ~uncertainty() = default;
};

// We offer this constant to go alongside "true" and "false".
const uncertainty maybe = uncertainty();

#endif // ARCTICTERN_UNCERTAINTY_HPP
