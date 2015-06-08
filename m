Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <CAG27Bk1SeeMwvYhLtaRFyLS0=ZXc6-wGgJJ_aQNJ=+NLMc5djw@mail.gmail.com>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
	<20150602120517.GK7285@ws.net.home>
	<CAG27Bk1rBbNzUXHxCx8Yhjiri-N1k=wfRkTPhKrZmg=UoqpTww@mail.gmail.com>
	<CAG27Bk1SeeMwvYhLtaRFyLS0=ZXc6-wGgJJ_aQNJ=+NLMc5djw@mail.gmail.com>
Date: Mon, 8 Jun 2015 22:01:06 +0100
Message-ID: <CAG27Bk0pmNoWPddbD1SQhW_g0vupK8So_DaeX53=-N1f3G3ABQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] pull: script(1) changes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 8 June 2015 at 10:15, Sami Kerola <kerolasa@iki.fi> wrote:
> On 7 June 2015 at 21:25, Sami Kerola <kerolasa@iki.fi> wrote:
>>>   - the "script: replay" test hangs :-(
>>
>> I cannot reproduce the problem, and hence I don't know what might be
>> going on. Perhaps the test should not be merged, or maybe it should
>> and some debugging ought to be added to see what exactly hangs and
>> why.
>
> My work desktop hung, and it is somehow caused by the 'sleep 0.1' in:

And indeed my home gear hung when sleeping a bit longer.

> https://github.com/kerolasa/lelux-utiliteetit/commit/c24d5e3903b0872d6ee956c45c0be760fa308a18#diff-2b763ca5b844d35fb0ade37e5dc2f4a1R28
>
> If I remove the sleep all works. When I put some other 'not very quick
> to run' command in place of the sleep hung again. With 'sleep 0.01'
> the execution is successful. I am starting to feel this might be a bug
> in script(1) --command option rather than in the test. I will continue
> investigation later this evening. Meanwhile all proposals what could
> be going on are welcome.

Correct guess earlier the day. The --command option had logic issue,
that is now fixed and available in my script3 branch. Fix was nothing
more than a removal of negation operator.

@@ -254,7 +254,7 @@ static void handle_io(struct script_control *ctl,
int fd, int i)
                /* without sync write_output() will write both input &
                 * shell output that looks like double echoing */
                fdatasync(ctl->master);
-               if (!ctl->isterm && !feof(stdin)) {
+               if (!ctl->isterm && feof(stdin)) {
                        char c = DEF_EOF;
                        write_all(ctl->master, &c, sizeof(char));
                }

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
