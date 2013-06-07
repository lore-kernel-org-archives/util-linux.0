Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130607102802.GB9955@x2.net.home>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
	<20130607102802.GB9955@x2.net.home>
Date: Fri, 7 Jun 2013 16:45:16 +0100
Message-ID: <CAG27Bk38mjk0xuE3ksM24g944C9FmciGtUe5JeOtVfpxfrQEdA@mail.gmail.com>
Subject: Re: [PATCH 00/19] pull: various clean ups and couple bug fixes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 7 June 2013 11:28, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jun 02, 2013 at 06:51:06PM +0100, Sami Kerola wrote:
>>       lib: remove unused code
>>       lscpu: add max MHz value to make cpu governor effects more visible
>>       docs: add lscpu max mhz to manual and bash completion
>
>  Applied.
>
>>       sfdisk: use libc error printing function, and symbolic exit values
>>       sfdisk: clean up usage() functions
>>       sfdisk: use program_invocation_short_name to determine program name
>>       docs: correct sfdisk --activate instructions
>>       sfdisk: remove --unhide and related functions
>>       sfdisk: replace my_warn() with warnx()
>
>  Not applied.
>
>>       rev: stop adding new line at the end when input does not have it
>>       rev: simplify new line detection and impossible test
>>       rev: reduce stream checking when closing read-only file descriptor
>
>  Applied.
>
>>       dmesg: make time format parsing to use enum bit field
>>       dmesg: add --time-format option
>>       dmesg: add iso-8601 time format
>>       docs: add --time-format option and ISO-8601 format to manual
>>       dmesg: make usage() a little bit shorter
>>       dmesg: more deterministic boot time detection
>
>  Not applied.
>
>>       cal: fix few type mismatches
>
>  Applied.

Karel, thank you for comments and partial merge. My week has utterly
crazy, so I have not had time to react on the earlier message. I'll do
my best fixing the reported issues sometime in next 10 days.
Meanwhile, all reading this list, have a good week.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
