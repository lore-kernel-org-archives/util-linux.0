Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <CAG27Bk1rBbNzUXHxCx8Yhjiri-N1k=wfRkTPhKrZmg=UoqpTww@mail.gmail.com>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
	<20150602120517.GK7285@ws.net.home>
	<CAG27Bk1rBbNzUXHxCx8Yhjiri-N1k=wfRkTPhKrZmg=UoqpTww@mail.gmail.com>
Date: Mon, 8 Jun 2015 10:15:52 +0100
Message-ID: <CAG27Bk1SeeMwvYhLtaRFyLS0=ZXc6-wGgJJ_aQNJ=+NLMc5djw@mail.gmail.com>
Subject: Re: [PATCH 00/12] pull: script(1) changes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 7 June 2015 at 21:25, Sami Kerola <kerolasa@iki.fi> wrote:
> On 2 June 2015 at 13:05, Karel Zak <kzak@redhat.com> wrote:
>>  script2
>
> Hi Karel,
>
> Corrections are available in the git repository at:
>
> git://github.com/kerolasa/lelux-utiliteetit.git script3

[snip]

>>   - the "script: replay" test hangs :-(
>
> I cannot reproduce the problem, and hence I don't know what might be
> going on. Perhaps the test should not be merged, or maybe it should
> and some debugging ought to be added to see what exactly hangs and
> why.

My work desktop hung, and it is somehow caused by the 'sleep 0.1' in:

https://github.com/kerolasa/lelux-utiliteetit/commit/c24d5e3903b0872d6ee956c45c0be760fa308a18#diff-2b763ca5b844d35fb0ade37e5dc2f4a1R28

If I remove the sleep all works. When I put some other 'not very quick
to run' command in place of the sleep hung again. With 'sleep 0.01'
the execution is successful. I am starting to feel this might be a bug
in script(1) --command option rather than in the test. I will continue
investigation later this evening. Meanwhile all proposals what could
be going on are welcome.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
