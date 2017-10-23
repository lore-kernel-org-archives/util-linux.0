Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 4/4] lib/timeutils: add common ISO timestamp masks
To: Karel Zak <kzak@redhat.com>
References: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
 <661c0a48-59bb-8263-9fd7-c1ef80b160f2@gmx.com>
 <20171023094959.dxlot6uqj5pvymwk@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <54ed1151-d782-815c-c986-1ae6ea9d20fe@gmx.com>
Date: Mon, 23 Oct 2017 15:54:19 -0400
MIME-Version: 1.0
In-Reply-To: <20171023094959.dxlot6uqj5pvymwk@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 10/23/2017 05:49 AM, Karel Zak wrote:
> On Sun, Oct 22, 2017 at 08:41:33PM -0400, J William Piggott wrote:
>>
>> * Start the ISO format flags at bit 0 instead of bit 1.
>>
>> * ISO timestamps have date-time-timzone in common, so move
>>   the TIMEZONE flag to bit 2 causing all timestamp masks
>>   to have the first three bits set and the last four bits
>>   as timestamp 'options'.
>>
>> * Change the 'SPACE' flag to a 'T' flag, because it makes
>>   the code and comments more concise.
>>
>> * Add common ISO timestamp masks.
>>
>> * Implement the ISO timestamp masks in all applicable code
>>   using the strxxx_iso() functions.
>>
>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>> ---
>>  include/timeutils.h    | 20 ++++++++++++++------
>>  lib/timeutils.c        |  2 +-
>>  login-utils/last.c     |  2 +-
>>  login-utils/lslogins.c |  3 +--
>>  login-utils/utmpdump.c |  4 +---
>>  misc-utils/uuidparse.c | 10 ++--------
>>  sys-utils/dmesg.c      |  4 +---
>>  sys-utils/hwclock.c    |  4 +---
>>  sys-utils/lsipc.c      |  2 +-
>>  sys-utils/rfkill.c     |  8 ++------
>>  term-utils/script.c    |  8 ++------
>>  11 files changed, 27 insertions(+), 40 deletions(-)
>>
>> diff --git a/include/timeutils.h b/include/timeutils.h
>> index e8a261462..7d5b13b2d 100644
>> --- a/include/timeutils.h
>> +++ b/include/timeutils.h
>> @@ -55,15 +55,23 @@ typedef uint64_t nsec_t;
>>  int parse_timestamp(const char *t, usec_t *usec);
>>  int get_gmtoff(const struct tm *tp);
>>  
>> -/* flags for strxxx_iso() functions */
>> +/* flags and masks for strxxx_iso() functions */
>>  enum {
>> -	ISO_8601_DATE		= (1 << 1),
>> -	ISO_8601_TIME		= (1 << 2),
>> +	ISO_8601_DATE		= (1 << 0),
>> +	ISO_8601_TIME		= (1 << 1),
>> +	ISO_8601_TIMEZONE	= (1 << 2),
>>  	ISO_8601_DOTUSEC	= (1 << 3),
>>  	ISO_8601_COMMAUSEC	= (1 << 4),
>> -	ISO_8601_TIMEZONE	= (1 << 5),
>> -	ISO_8601_SPACE		= (1 << 6),
>> -	ISO_8601_GMTIME		= (1 << 7)
>> +	ISO_8601_T		= (1 << 5),
>> +	ISO_8601_GMTIME		= (1 << 6),
>> +	ISO_TIMESTAMP		= 0x07,   /* 2017-10-13 17:27:04-04:00 */
>> +	ISO_TIMESTAMP_T		= 0x27,   /* 2017-10-13T17:27:04-04:00 */
>> +	ISO_TIMESTAMP_DOT	= 0x0F,   /* 2017-10-13 17:27:04.350452-04:00 */
>> +	ISO_TIMESTAMP_DOT_T	= 0x2F,   /* 2017-10-13T17:27:04.350452-04:00 */
>> +	ISO_TIMESTAMP_COMMA	= 0x17,   /* 2017-10-13 17:27:04,350452-04:00 */
>> +	ISO_TIMESTAMP_COMMA_T	= 0x37,   /* 2017-10-13T17:27:04,350452-04:00 */
>> +	ISO_TIMESTAMP_COMMA_G	= 0x57,   /* 2017-10-13 21:27:04,350452+00:00 */
>> +	ISO_TIMESTAMP_COMMA_GT  = 0x77    /* 2017-10-13T21:27:04,350452+00:00 */
>>  };
> 
> 
> Would be possible to use ISO_8601_* to compose ISO_TIMESTAMP_*
> macros? Your hardcoded magic 0x constants make the header file
> less readable. I mean
> 
>   ISO_TIMESTAMP = ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE

We could eliminate wrapping by dropping the unnecessary 8601. Using the
longest example:

	ISO_TIMESTAMP_COMMA_GT = ISO_TIMESTAMP_COMMA | ISO_GMTIME | ISO_T

> 
> and it would be also nice to add somehow info about "usec" to the
> macro name (see ISO_TIMESTAMP vs. ISO_TIMESTAMP_COMMA).

8601 only uses comma or dot for the radix character; so 'COMMA/DOT'
imply the presence of a fractional part.

> What about:
> 
>     - use "U" prefix for usec times
>     - use "GM_" prefix for GMTIME
> 
> for example:
> 
>    ISO_TIMESTAMP           = ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE,
>    ISO_UTIMESTAMP_DOT      = ISO_TIMESTAMP | ISO_8601_DOTUSEC,
>    ISO_UTIMESTAMP_COMMA    = ISO_TIMESTAMP | ISO_8601_ISO_8601_COMMAUSEC,
>    ISO_GM_UTIMESTAMP_COMMA = ISO_UTIMESTAMP_COMMA | ISO_8601_GMTIME
> 
> and so on.

IMO the macros are easier to remember, write, and read, if they all
begin the same and the optional parts are suffixes. All of the masks are
basic ISO Timestamps (date time timezone), the rest are minor variations.

> 
> The another nice way how to describe datetime format is to use chars to
> complete describe the format
> 
>  ISO_YYYYMMDD_HHMISS             = ISO_8601_DATE | ISO_8601_TIME
>  ISO_YYYYMMDD_HHMISS_TZ          = ISO_YYYYMMDD_HHMISS | ISO_8601_TIMEZONE
>  ISO_YYYYMMDD_HHMISS_DOT_USEC    = ISO_YYYYMMDD_HHMISS | ISO_8601_DOTUSEC
>  ISO_YYYYMMDDTHHMISS_COM_USEC    = ISO_YYYYMMDD_HHMISS | ISO_8601_COMUSEC
>  ISO_YYYYMMDDTHHMISS_COM_USEC_TZ = ISO_YYYYMMDDTHHMISS_COM_USEC | ISO_8601_TIMEZONE
> 
> the macro name is longer, but very descriptive and easy to extend :-)

That notation works well when necessary, but an 8601 timestamp is so
specific that duplicating it in the macro name is redundant and, I
think, visually mesmerizing.

> 
>  Karel
> 
> 
