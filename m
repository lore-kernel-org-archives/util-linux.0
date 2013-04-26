Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130426113849.GE4839@x2.net.home>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
	<1365882901-11429-6-git-send-email-kerolasa@iki.fi>
	<20130413215913.GF11968@rampage>
	<20130426113849.GE4839@x2.net.home>
Date: Fri, 26 Apr 2013 13:29:26 +0100
Message-ID: <CAG27Bk36VL=ieHapgRGfVrmkZB8pWR2hcaNPCZvMu4273W8J+w@mail.gmail.com>
Subject: Re: [PATCH 05/33] bash-completion: prefer bash 3.x 'here string' syntax
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 26 April 2013 12:38, Karel Zak <kzak@redhat.com> wrote:
> On Sat, Apr 13, 2013 at 05:59:13PM -0400, Dave Reisner wrote:
>> On Sat, Apr 13, 2013 at 08:54:33PM +0100, Sami Kerola wrote:
>> > The '< <' syntax is bash 2.x trick, and <<< does the same job when bash
>> > 3.x is in use.  For some unknown reason my bash 4.2.45(2)-release became
>> > allergic to old syntax today(?).
>>
>> I don't follow this. The syntax is <(commands), which is a process
>> substitution. It creates a temporary file descriptor which can be
>> redirected via <. It still very much works, and I don't expect this to
>> break any time soon. It's likely more memory efficient since there's no
>> need to expand the output in place -- it can just be read off of the
>> file descriptor.
>>
>> I think you should figure out what's wrong with your shell instead of
>> doing this.
>
>  Sami?

Hi Dave & Karel,

Sorry, I have forgot to have look of this. It is best to drop the
patch for now, as I am not sure why old syntax did not work for me
expected way.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
