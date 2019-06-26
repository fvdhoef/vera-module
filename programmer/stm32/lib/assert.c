#define MODULE_NAME "ASSERT"
#define MODULE_TYPE ANSI_ERROR

#include "lib.h"

/**
 * @brief      Assert handler used by assert function
 *
 * @param      filename    The filename
 * @param      line        The line
 * @param      function    The function
 * @param      expression  The expression
 */
void __assert_func(const char *filename, int line, const char *function, const char *expression) {
    __disable_irq();
    DBGF("Assertion (%s) failed in %s (%s:%d)\n", expression, function, filename, line);
    while (1) {
    }
}
