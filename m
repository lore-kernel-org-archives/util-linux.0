Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140407093604.GF22126@x2.net.home>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
	<1394397023-7050-2-git-send-email-kerolasa@iki.fi>
	<20140407093604.GF22126@x2.net.home>
Date: Mon, 7 Apr 2014 15:09:18 +0100
Message-ID: <CAG27Bk1ErxOt4SxmQFERCCK7KTWZqoT4Nkbk-f+aw_PzguepVw@mail.gmail.com>
Subject: Re: [PATCH 02/10] kill: fix coding style
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 7 April 2014 10:36, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Mar 09, 2014 at 03:30:15PM -0500, Sami Kerola wrote:
>> The kill was deprecated at the time lot of other tools got style
>> unification.  Now when deprecation is lifted it is time to get kill
>> cleaner.
>
> OK, all applied.
>
> I also did some changes to the code and the man page. The most
> visible change is that kill(1) now returns 64 (like mount or chcpu)
> for partial success when more than one process specified.
>
>   $ kill -s 0 firefox mutt xxx; echo $?
>   kill: cannot find process "xxx".
>   64
>
> the old version always return "1" in this situation.

Thank you, and great that you noticed the !check_all mistake. I will
try to add more kill regression tests sometime soon.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
