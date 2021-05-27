# All Error Messages and Exit Codes in one file for *continuity* across the board.
#
# Having these scattered across the test suite was making it hard to track exit codes message format continuity.
#

EQUAL_EXITCODE=50
EQUAL_TEXT_MESSAGE="Expected text to equal provided value"
EQUAL_TEXT_NOT_MESSAGE="Expected text not to equal provided value"
EQUAL_TEXT_NO_ARGUMENT_MESSAGE="Missing required text argument for text 'equal' matcher: [expected text]"
EQUAL_LIST_MESSAGE="Expected list value(s) to equal provided value(s)"
EQUAL_LIST_NOT_MESSAGE="Expected list value(s) not to equal provided value(s)"
EQUAL_ARRAY_MESSAGE="Expected array elements(s) to equal provided value(s)"
EQUAL_ARRAY_NOT_MESSAGE="Expected array elements(s) not to equal provided value(s)"

EMPTY_EXITCODE=51
EMPTY_TEXT_MESSAGE="Expected text to be empty (zero-length)"
EMPTY_TEXT_NOT_MESSAGE="Expected text not to be empty (zero-length)"
EMPTY_LIST_MESSAGE="Expected list to be empty (zero-length)"
EMPTY_LIST_NOT_MESSAGE="Expected list not to be empty (zero-length)"
EMPTY_ARRAY_MESSAGE="Expected array to be empty (no array elements)"
EMPTY_ARRAY_NOT_MESSAGE="Expected array not to be empty (no array elements)"

CONTAIN_EXITCODE=52
CONTAIN_TEXT_MESSAGE="Expected text value to contain subtext"
CONTAIN_TEXT_NOT_MESSAGE="Expected text value not to contain subtext"
CONTAIN_TEXT_NO_ARGUMENT_MESSAGE="Missing required text argument for 'contain' matcher: [expected text]"
CONTAIN_LIST_MESSAGE="Expected list to contain item with subtext"
CONTAIN_LIST_NOT_MESSAGE="Expected list not to contain item with subtext"
CONTAIN_LIST_NO_ARGUMENT_MESSAGE="Missing required argument for list 'contain' matcher: [expected text]"
CONTAIN_ARRAY_MESSAGE="Expected array to contain item with subtext"
CONTAIN_ARRAY_NOT_MESSAGE="Expected array not to contain item with subtext"
CONTAIN_ARRAY_NO_ARGUMENT_MESSAGE="Missing required argument for array 'contain' matcher: [expected text]"

WILDCARD_EXITCODE=57
WILDCARD_TEXT_MESSAGE="Expected text value to contain wildcard pattern"
WILDCARD_TEXT_NOT_MESSAGE="Expected text value not to contain wildcard pattern"
WILDCARD_TEXT_NO_ARGUMENT_MESSAGE="Missing required argument for 'wildcard' matcher: [expected pattern]"