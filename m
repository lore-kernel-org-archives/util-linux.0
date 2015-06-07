Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20150602120517.GK7285@ws.net.home>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
	<20150602120517.GK7285@ws.net.home>
Date: Sun, 7 Jun 2015 21:25:07 +0100
Message-ID: <CAG27Bk1rBbNzUXHxCx8Yhjiri-N1k=wfRkTPhKrZmg=UoqpTww@mail.gmail.com>
Subject: Re: [PATCH 00/12] pull: script(1) changes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 2 June 2015 at 13:05, Karel Zak <kzak@redhat.com> wrote:
>  script2

Hi Karel,

Corrections are available in the git repository at:

git://github.com/kerolasa/lelux-utiliteetit.git script3

The script2 is left untouched so that you, or anyone else can diff the
script.c two branches in order to see what was done.

>   - the branch contains also rtcwake changes!

Branch rtcwake3, script3, and more3 are now on top of the commit

c24d5e3903b0872d6ee956c45c0be760fa308a18

>   - the "script: replay" test hangs :-(

I cannot reproduce the problem, and hence I don't know what might be
going on. Perhaps the test should not be merged, or maybe it should
and some debugging ought to be added to see what exactly hangs and
why.

>   - no tested with HAVE_LIBUTEMPTER, you need:
>
>           -       utempter_add_record(master, NULL);
>           +       utempter_add_record(ctl.master, NULL);

Ooops. Fixed, and compiled successfully with libutempter.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
