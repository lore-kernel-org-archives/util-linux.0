Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.131]:57775 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbaDOJL1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 05:11:27 -0400
Message-ID: <534CF73C.50309@bernhard-voelker.de>
Date: Tue, 15 Apr 2014 11:09:16 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/7] tests: check kill is converting signals names correctly
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>	<1397298524-3364-5-git-send-email-kerolasa@iki.fi>	<534B0E1B.4040208@bernhard-voelker.de>	<CAG27Bk1w81SaDxomfv14cDwZjFi_6nyq3uHHtc+JxV6xB5rp0Q@mail.gmail.com>	<CAG27Bk0k46-Vnj5Jonb_xXkW+h_WZTt=YXfOroy8nMvaiwLdCg@mail.gmail.com>	<534C096C.2070500@bernhard-voelker.de> <CAG27Bk1pgj3QeLgcUCP05h0QnLsLXibQVkFj3egQbG1nmxew3Q@mail.gmail.com>
In-Reply-To: <CAG27Bk1pgj3QeLgcUCP05h0QnLsLXibQVkFj3egQbG1nmxew3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/14/2014 09:00 PM, Sami Kerola wrote:
> On 14 April 2014 17:14, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> Most of the tests could use pid, but I am afraid there should be at
> least one of them using name. Else killing by name remains untested.

What about creating a test 'kill_by_name', and avoiding complexity
in the other tests? They all have a certain purpose each, so there's
no need to put a certain aspect into all of them.

> Of course simple kill by name test could do the job, but I am not
> hugely in favor to simplify tests until they work without
> understanding why they fail in first place.

Agreed. Unfortunately, I didn't find *the* reason for the failure yet.
BTW, I often see both "all_processes" and "name_to_number" failing here.

It seems that there are several issues.
First of all, this looks odd in the receiver program:

 > +	if (!stat(argv[1], &statbuf)) {
 > +		if (S_ISDIR(statbuf.st_mode))
 > +			xasprintf(&pid_path, "%s/%d", argv[1], getpid());
 > +	} else
 > +		xasprintf(&pid_path, "%s", argv[1]);

What if the argv[1] is stat()able but not a directory?

Anyway, I'm 40:60 against letting the receiver program decide where
the witness file is located, i.e. I'd rather use deterministic names
everywhere. E.g. in the 'name_to_number' tests, the name of the witness
files could contain the signal name rather than using unsafe mktemp.

Furthermore, the open() call would return -1 upon failure instead
of 0 as assumed here:

 > +	if (!(fd = open(pid_path, O_WRONLY | O_CREAT | O_TRUNC, mode)))
 > +		err(EXIT_FAILURE, "cannot open pid file: %s", pid_path);

Re. the "all_processes" test: I'm not sure how su(1) and the intermediate
shell change the signal handling. Maybe the reason for the failure is
somehow related to this, because $! will refer to the shell's PID rather
than to that of the receiver program.
Anyway, maybe it's better to use $TS_CMD_SU instead of the local 'su',
or even adding a dedicated setuid() helper.

As already said, these are just side notes.

Have a nice day,
Berny
