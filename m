Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20151216111530.GA13224@ws.net.home>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
	<1450208404.1111354.468335457.59637230@webmail.messagingengine.com>
	<20151216111530.GA13224@ws.net.home>
Date: Thu, 17 Dec 2015 18:16:59 +0000
Message-ID: <CAG27Bk1r0OL961KCtq58Mo2W2ir=71yD30zaKVXW73rVtO30bQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] pull: bash-completion updates
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 16 December 2015 at 11:15, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Dec 15, 2015 at 08:40:04PM +0100, Benno Schulenberg wrote:
>> On Mon, Dec 14, 2015, at 22:54, Sami Kerola wrote:
>> > The pull adds new function, print_long_opts(), to c.h and
>> > it does what one might expect a function of such name do.
>>
>> Hm.  You want to add --print-long-opts to almost all commands?
>
> It seems so, and I'm really not sure with this solution.

Fair enough.

>> And burden all --help outputs with listing it?  But... is this
>> option useful for users?  Or really only for bash-completion?
>
> It means that always when I press <tab> on command line then the util is
> executed with --print-long-opts. It seems expensive.
>
> From my point of view it would be enough to have tools/checkcompletion
> script to extract "struct option" from our utils and check if the options
> are also in bash-completion/<name> and in the util man page.

If this is the preference then the patchset is mostly throwaway. Oh well,
such is life. Let's see if the week after the Christmas on-call there's time to
think how to make options parsing work.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
