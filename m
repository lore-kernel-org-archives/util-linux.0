Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64451 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK5D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:57:03 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so6219452pab.33
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:57:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1400934651.15812.121082081.6ADC22B3@webmail.messagingengine.com>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<1400929696-12548-2-git-send-email-kerolasa@iki.fi>
	<1400934651.15812.121082081.6ADC22B3@webmail.messagingengine.com>
Date: Sun, 25 May 2014 11:57:01 +0100
Message-ID: <CAG27Bk2bgpkodp2FgxmXkUhoSe8rWAuBFh40bU6t+1rmavHg2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] setterm: add usage() descriptions
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 May 2014 13:30, Benno Schulenberg <bensberg@justemail.net> wrote:

Hi Benno,

Thank you for all four reviews.

> On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
>> +     fputs(_(" --inversescreen <on|off>          inverse foreground and background colors\n"), out);
>
> s/inverse/swap/
> s/colors/colors for the whole screen/

The text is updated.

> And all these <on|off> should be [on|off], like in the man page,
> as they are literal arguments and optional.

Ah, I see. It would be really good to get an example of literate
argument to both howtos.

Documentation/howto-man-page.txt
Documentation/howto-usage-function.txt

Maybe something like this

diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-page.txt
index 5ca4af0..7ad76a2 100644
--- a/Documentation/howto-man-page.txt
+++ b/Documentation/howto-man-page.txt
@@ -48,6 +48,10 @@ Tell in description option
 .I argument
 is required.
 .TP
+\fB\-l\fR, \fB\-\-literal\fR \fIword\fR
+Tell in description option argument is required and that it can be only
+.BR word .
+.TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
diff --git a/Documentation/howto-usage-function.txt
b/Documentation/howto-usage-function.txt
index dd1f4ed..c37ea0f 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -47,6 +47,7 @@ Options:
  -n, --no-argument       option does not use argument
  -o, --optional[=<arg>]  option argument is optional
  -r, --required <arg>    option requires an argument
+ -L, --literal [arg|foo] required argument is one of the literal strings
  -z                      no long option
      --xyzzy             a long option only
  -e, --extremely-long-long-option

>> +     fputs(_(" --foreground    <default|color>   set foreground color\n"), out);
>
> default|<color>

Colors are literal strings so [color], and that can be short cut to
[default|color] where color possibilities are explained in later line.

>> +     fputs(_(" --reverse       <on|off>          reverse all output options\n"), out);
>
> Hm?  Shouldn't that be "set reverse video"?
> Or maybe "swap foreground and background colors from here"?
> It doesn't invert brightness or other attributes.
>
>> +     fputs(_(" --clear         <all|rest>        clear screen and set cursor position\n"), out);
>
> [all|rest]
>
>> +     fputs(_(" --regtabs       <1-160>           set default tab stop position\n"), out);
>
> To be consistent this should be "--regtabs <number>", and then add that
> <number> can be 1..160.  But that loses conciseness.

Options --tab argument <number> defines length of a specific tab,
while the --regtabs is a range. In former the number is value, and in
later more like literal string, constant, or a definition.

>> +     fputs(_(" --blank         <0-60|force|poke> set inactivity interval\n"), out);
>
> --blank  [<number>|force|poke]
> and <number> can be 1..60 (minutes)

Same here. This dualistic 'number as value' and 'number as definition'
may need an example to howtos files. IMHO the long description in
which range is '<number>' and later text tells '<number> has range 1
to 60' is too verbose, good usage() is brief, man page as verbose as
needed.

New version:
https://github.com/kerolasa/lelux-utiliteetit/commit/2354f1f8085b93c50505fe4fb09b1792153d75f1

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
