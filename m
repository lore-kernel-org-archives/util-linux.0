Return-Path: <SRS0=qYTN=2H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA81C43603
	for <util-linux@archiver.kernel.org>; Tue, 17 Dec 2019 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECD52053B
	for <util-linux@archiver.kernel.org>; Tue, 17 Dec 2019 20:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lO7px9BF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfLQUoC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:44:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:44769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfLQUoB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 17 Dec 2019 15:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576615435;
        bh=drt6moM9wiUdsw5LNu6gLhIokHXeDxzhgUhIU1nCt2E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lO7px9BFX0zYzWmTbd51RwozkmlrfWeZVMlSiFRA0TjaRfpsKeDOIol65grWXjLdn
         plsNnbZtt7w+axgdoim6xfSGMTN2hIr6oZINqamCSTZtq2Kfr25iSQCDomwKmNCw3Q
         e6IUH2A/uG3B0Q71fXN5E8SFkGqmbsDGux6U/5mc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mua.gmx.com ([68.56.186.98]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1iTV8G1xYU-00H8sZ; Tue, 17
 Dec 2019 21:43:54 +0100
Date:   Tue, 17 Dec 2019 15:43:15 -0500 (EST)
From:   J William Piggott <elseifthen@gmx.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] doc: howto-man-page.txt: Use font macros instead of font
 escapes
In-Reply-To: <20191216222032.GA25430@rhi.hi.is>
Message-ID: <nycvar.YAK.7.76.1912171449170.1929@zhn.tzk.pbz>
References: <20191216222032.GA25430@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:lvQeuAbV+HYtH4xLib3eRq9YTW3xEDUCpGaVmaBBn4qxNQxYheD
 /nVxY5StFu6QXFhcHyURDHqLSqRRUaWgYjKQoBqZnFF3hB0M5OjZty8HIquXkJVoJU2bw8z
 pVyNfg96MIlUHxhRqBC840fOTrc/qB7uqqakWZNccPmVXV3wqqNbXUG875wnzQZw1D+UaQI
 3NUrL8/5irTciHU+cLuKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G0wc1NHL/Qk=:NBJuWRRPEt+qin9C7C0WUP
 CXDLho10JSERrbjVBRXSF8DOW9V7MQ/h2VCn7P92lPeK4hso+s1XApRMpqvMUW2f2Px1FWu9Y
 8TQ9oR3rIm9oXdvpo8rPwyCeNkPm1wg8WFeZrWu+i4HRulMSKH/raw6wD9qmPRScL3pci71Io
 y3NqyT3/S9bNOEjO5Gbkvs7SzUkMgQkhFGB+0wQtEWsMQA5wbCRIB38NMizWxFZgOQoDfhz60
 D/MFj/FA162I9kNZfRJ2uCVFQFB7C8zYZYcezlLUa7YqqTVYHrttpIxmRvzITycSAcX2UH0co
 eM/SDPqf9hXzK5ssfceULOX0vAYtdwpQ/nm35Yy7yEdFA9k1BwYMen7DilDBYpL7tpdYKqUiN
 AUHcIPzEs97v6ZfIvB75FLfukf1S86cRe625FQ7JfxDZZxj6QDFfyZq7Xl0HGRtetRjMeOgdj
 N6tS/o0ANfrVrjT6fL1IDYVy3NSmnpec/NTOQaYOIJbmndIqGJz1LgoFI6ec4gOg+iNhB7mhK
 vw7Qukf7Z5DA52yc0BX5sKH88szZf3Pe/Po5J6q9EHPBNTBLbqfTJZd7FGUoiSPwJB4f43fmh
 UCTk1tV9Con6I4rvdSfM94fK9RU7wDS4Uu5oJ/fqQpF+6hFczuxPEmVKV/LV2fxNFDYKAFtcw
 vt6Eq9wbSgvYJcZLMB9UmEEgabnsBXVcILGL9Dw3nSKS8JGj7vA1XT9nN3uelRw0mOWieb42U
 lLVj3iITgsAsdmqrYE6WVSA/ncnDKj5vnT6UurIz3Me+HygArDnwcvBYQD53nNJ/6KNlxgh2p
 sDRealaL6L3w0eHLBtSOHSFXBDRV1iLdPGbaQ6y+x/LJT6PsE6PMOoKICKsY5lnceoBg5K7zq
 SI1ETYgFhCapByiiH3SHm4hr4AJo2lHOCyIMm8HjXMIg+0Us4A13+LTNAQ3i4ncqaRzb+/mXi
 8MSXZcTY/uBQrZutkQw/L3lfEMnv3JUw5YeIGk1DJrjLqZip9a8ESudazfY0T0I3C2XImbXhd
 TGqrUgEkp5Kqxlkw136Jg3WYr4oj/RotYVd+H8AeudIWRqbR6cxLb+Y0LsUeIYRHSZccrlcWi
 nTdpe1qmIVarna0EV06UK95N+TM/C74pkz9bd4VvEf7vZu7PUtkTmC238aIKwL09jyrn11SQH
 P+/4RMQw63D+PuI1NjaEiEVIsf00sDIQqe/8sn7m5QsjUZK3Q8yjz/7V3PFSgQeDVDH8L9SMR
 wNGUY32vUAV+JnO45xPxHBtFm+pJH7hhYWJE0js8RhNyqHDm5ySFVBFl/NE0=
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On Mon, 16 Dec 2019, Bjarni Ingi Gislason wrote:

>  Use font macros instead of font escapes (\f[BIPR]).
>
>  The escape '\c' ("connect to next input text")
> is used to join the output of two macros without a space character.
> This is similar to the '\' escape at the end of a line.
>
>  Font escapes make the text more difficult to read.

All inline escapes make the *source* difficult to read, maintain, are erro=
r
prone, and hostile for text-to-speech. That was a big problem in html sour=
ce
decades ago and part of the reason that css was invented.

I wish you luck. I tried to convince this project that inline escapes shou=
ld be
avoided, but everyone here seems to be in love with them. I had them all
stripped out of hwclock(8), but another contributor kept insisting on putt=
ing
them back. I finally gave up and started using them too.

>
> ###
>  Changes based on:
>
>  Use a macro to change to the italic font,
> instead of \fI [1], if possible.
>  The macros have the italic corrections,
> but "\c" removes the "\/" part.
>
>  Or
>
> add the italic corrections.
> [1] man-pages(7) [Debian package "manpages"]

That must be Debian hack, but Michael should adopt a no inline-escape poli=
cy
for the man page project, IMO. Although it shouldn't limited to italic.

>
> ###
>
> Change a HYPHEN-MINUS (code 0x55, 2D) to a minus (\-), if in front of a
>
> 1) name for an option
>
> 2) negative number to be printed.
>
> ###
>
> Wrong distance between sentences or protect the indicator.
>
> a) Separate the sentences and subordinate clauses;
> each begins on a new line.
> See man-pages(7) [package "manpages"] and "info groff".

This is Michael's policy, and a good one I think. It would be a big task t=
o do
this for the whole project.

>
> Or
>
> b) Adjust space between sentences (two spaces),
This is what the project currently does (is supposed to do).

>
> c) or protect the indicator by adding "\&" after it.
>
> The "indicator" is an "end-of-sentence character" (.!?).

This is called line termination, all three of which are not always;
hence the reason to make the distinction in roff.

>
>  The amount of space between sentences in the output can then be
> controlled with the ".ss" request.

If you can convince Karl to adopt any of these rules then you should inclu=
de
the chosen ones in the project documentation.

>
> Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
> ---
> Documentation/howto-man-page.txt | 28 ++++++++++++++++++----------
> 1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-=
page.txt
> index 55734af91..f2b352dac 100644
> --- a/Documentation/howto-man-page.txt
> +++ b/Documentation/howto-man-page.txt
> @@ -30,10 +30,13 @@ Each manual page needs some sort of description of t=
he command.
> Write such here.
> .SH OPTIONS
> .TP
> -\fB\-n\fR, \fB\-\-no\-argument\fR
> +.BR \-n ,\  \-\-no\-argument
> +.\" \fB\-n\fR, \fB\-\-no\-argument\fR

Remove the old, don't comment it.
Same for below.

> This option does not use an argument.
> .TP
> -\fB\-\-optional\fR[\fI=3Dargument\fR]
> +.BR \-\-optional [ =3D\c
> +.IR argument ]
> +.\" \fB\-\-optional\fR[\fI=3Dargument\fR]
> Tell in this description that the
> .I argument
> is optional, and what happens when it is or is not given.  Notice that t=
he word
> @@ -59,18 +62,22 @@ to be the same, but in fact the former is two separa=
te options while the
> later will use
> .B n
> as option argument of
> -.BR -o .
> +.BR \-o .
> So it is best to avoid short forms of optional options altogether.
> .TP
> -\fB\-r\fR, \fB\-\-required\fR \fIargument\fR
> +.BR \-r ,\  \-\-required\ \c
> +.I argument
> +.\"\fB\-r\fR, \fB\-\-required\fR \fIargument\fR
> Tell in this description that the
> .I argument
> is required.
> .TP
> -\fB\-V\fR, \fB\-\-version\fR
> +.BR \-V ", " \-\-version
> +.\"\fB\-V\fR, \fB\-\-version\fR
> Display version information and exit.
> .TP
> -\fB\-h\fR, \fB\-\-help\fR
> +.BR \-h ,\  \-\-help
> +.\"\fB\-h\fR, \fB\-\-help\fR
> Display help text and exit.
> .SH NOTES
> Tell details that users might need to know.  For example, kernel feature=
 or
> @@ -105,7 +112,8 @@ one.
> .\"
> .PP
> When in the source a new sentence begins somewhere midline, it should us=
e a
> -double space before its initial letter.  This is done because \fBgroff\=
fR
> +double space before its initial letter.  This is done because
> +.B groff
> uses a double space after a sentence when this sentence ends at the end =
of
> an input line and the next sentence begins on the next line.
> Unless a double space is used before other sentence starts as well, the
> @@ -139,10 +147,10 @@ Another file.
> Write typical and/or clever use examples here.  The below examples are s=
tupid,
> and you should never write them in a real man page.
> .TP
> -.B example -h
> +.B example \-h
> Output help screen.
> .TP
> -.B example -V
> +.B example \-V
> Output version information.
> .SH "EXIT STATUS"
> This section can be left out if the command has only two return values,
> @@ -171,7 +179,7 @@ etc
> .RE
> .SH AUTHORS
> .MT rjh@\:example.org
> -Random J. Hacker
> +Random J.\& Hacker
> .ME
> .br
> .MT fred@\:example.com
> --
> 2.24.0
>
