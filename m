Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:44153 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbcCHQdj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Mar 2016 11:33:39 -0500
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
To: =?UTF-8?Q?=c3=81ngel_Gonz=c3=a1lez?= <ingenit@zoho.com>,
        util-linux@vger.kernel.org
References: <56D7409A.6050407@suse.cz>
 <20160303013722.22156xdxrqmywgw0@webmail.alunos.dcc.fc.up.pt>
 <56D8648F.60504@suse.cz> <56D9B445.5080808@suse.cz>
 <20160304190312.17036kwlv8g5ydk4@webmail.alunos.dcc.fc.up.pt>
 <56DA1F2A.5040104@zoho.com>
Cc: up201407890@alunos.dcc.fc.up.pt
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56DEFEE1.1080507@suse.cz>
Date: Tue, 8 Mar 2016 17:33:37 +0100
MIME-Version: 1.0
In-Reply-To: <56DA1F2A.5040104@zoho.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mar 5, 2016 at 00:50 Ángel González wrote:
> I was thinking about this and the problem is actually that runuser
> returns (and control is returned to the privileged parent) while there's
> an unprivileged descendant with a handle to the tty.
> Thus, it seems that it could be solved by having runuser run the child
> into a new cgroup and refusing to return while there's any remaining
> process there.

In general, it is a good idea.

But from compatibility aspect, it is a bad idea to change it to the 
default behavior. Imagine all those poorly written legacy helpers that 
run daemons without proper disconnecting from the terminal. All those 
will be stalled.

I can imagine new --term-wait option, eventually --term-kill. But I am 
not sure, whether it is no over-complicated.

> Although depending on the exact way that people is expecting to use job
> control, that might still interefere despite not changing the session
> leader. Do we know actual usages that should continue working?
>
There is not exact list what will will break.

But imagine that many users use daily things like simple example below. 
(In a real life, you will not want to run sleep, but something more 
sophisticated (e. g. build process inside chroot that needs sudo).)

# sudo -u nobody sleep 10 &
[1] 28327
~ # fg
sudo -u nobody sleep 10
^Z
[1]+  Stopped                 sudo -u nobody sleep 10
~ # bg
[1]+ sudo -u nobody sleep 10 &
~ #
~ #
[1]+  Done                    sudo -u nobody sleep 10
~ #

It will be not possible any more with setsid().

You will get:
# sudo -u nobody sleep 10 &
[1] 28390
~ # fg
sudo -u nobody sleep 10
^Z^Z^Z^Z^Z^Z^Z^Z

You are stuck, ^Z does not work, and you cannot switch the task back to 
background. You can only press ^C.

Exactly the same will affect
runuser --command "sleep 10"

Additionally, both su and runuser already offer two variants. You can 
test the difference yourself:

Without job control:
su nobody --command "sleep 10" &
vs.
With job control:
su nobody --session-command "sleep 10" &

After calling it, type:
fg
and then Control-Z.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
