Return-Path: stefw@redhat.com
Message-ID: <53C4DED8.2070706@redhat.com>
Date: Tue, 15 Jul 2014 09:57:12 +0200
From: Stef Walter <stefw@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive
 SIGUSR1
References: <1404718284-4192-1-git-send-email-stefw@redhat.com> <20140715074717.GN30288@x2.net.home>
In-Reply-To: <20140715074717.GN30288@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 15.07.2014 09:47, Karel Zak wrote:
> On Mon, Jul 07, 2014 at 09:31:24AM +0200, Stef Walter wrote:
>>  /* Get user name, establish parity, speed, erase, kill & eol. */
>>  static char *get_logname(struct options *op, struct termios *tp, struct chardata *cp)
>>  {
>> @@ -1625,9 +1676,18 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
>>  
>>  	while (*logname == '\0') {
>>  
>> +		reprompt_flag = 0;
>> +
>>  		/* Write issue file and prompt */
>>  		do_prompt(op, tp);
>>  
>> +		/* If asked to reprompt *before* terminal input arrives, then do so */
>> +		if (!wait_for_term_input(STDIN_FILENO) && reprompt_flag != 0) {
>> +			if (op->flags & F_VCONSOLE)
>> +				termio_clear(STDOUT_FILENO);
>> +			continue;
>> +		}
> 
>  Now when I think about it.. would be better to have this feature
>  optional? I think it's overkill to have it enabled on all machines. 

Sure.

>  The another story is the signal usage (and possible race with login(1) as 
>  discussed at https://bugzilla.redhat.com/show_bug.cgi?id=1110763). 
>  
>  What about  for example: 
> 
>    agetty --reload-trigger <file>

As I said in the above bugzilla bug, I don't mind doing this ... but in
my opinion unix signals are meant exactly for this use case, and are
used by many (most?) other linx processes as a reload trigger.

>  and use inotify for the <file>. I guess this way also allows to avoid
>  the ioctl() tty voodoo and you can use select() for the inotify and
>  tty file descriptors.

Unfortunately that's not how it works. When in canonical mode, the tty
file descriptor only becomes readable once a complete line has been
entered. I've verified that select() does not return until <enter> is
pressed.

Hence the switch to non-canonical mode, until the first character is
pressed, and then back to canonical.

Cheers,

Stef
