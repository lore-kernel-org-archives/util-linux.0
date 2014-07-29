Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140729074408.GO8533@x2.net.home>
References: <1406487666-19466-1-git-send-email-kerolasa@iki.fi>
	<20140729074408.GO8533@x2.net.home>
Date: Tue, 29 Jul 2014 09:27:29 +0100
Message-ID: <CAG27Bk3afJJB3sT1Kc_yrvQei1eALKesd=zCs98k6LESB2BF6A@mail.gmail.com>
Subject: Re: [PATCH] wall: wrap message header when it exceeds 79 characters
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 29 July 2014 08:44, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jul 27, 2014 at 08:01:06PM +0100, Sami Kerola wrote:
>> Header truncation started to happen more often after commit
>> d81c30553f4fb49173d38f69edff4b0b67a18b65 that made the header to be
>> longer.
>
>  Well, I did the change to be compatible with wall from sysvinit. The
>  original (BSD) wall header format was
>
>   Broadcast Message from %s@%s
>            (%s) at %d:%02d ...
>
>  it means two lines.
>
>> +             len = strlen(lbuf);
>> +             for (i = 0; 0 < len; i++)
>> +                     len -= fprintf(fp, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH,
>> +                                    lbuf + (i * TERM_WIDTH)) + 4;
>
>  Now you want to reintroduce the old behavior (more lines for the header),
>  but with a completely random split... I don't think it's a good idea.
>
>  If we don't want the sysvinit header then it would be better to
>  compose nice proper header than depend on for (i = 0; 0 < len;
>  i++)...

Sounds like the options are

1. change to header format
2. add to documentation header might not have always all information
if it is too long

After reading Karel's advice I am thinking the second option is more acceptable.
I will wait couple days before sending a patch just in case someone has opinion
in against or in favor of the option 2.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
