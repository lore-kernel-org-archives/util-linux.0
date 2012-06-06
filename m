Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:53301 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2FFNHS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Jun 2012 09:07:18 -0400
Message-ID: <4FCF5602.8090804@bernhard-voelker.de>
Date: Wed, 06 Jun 2012 15:07:14 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Ludwig Nussel <ludwig.nussel@suse.de>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: su: calling setsid() for -c only if non-root user?
References: <4FCF441C.1090400@bernhard-voelker.de> <4FCF4FFD.70204@suse.de>
In-Reply-To: <4FCF4FFD.70204@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/06/2012 02:41 PM, Ludwig Nussel wrote:
> Bernhard Voelker wrote:
>> I am playing around with the --command and --session-command options of su,
>> and I noticed that setsid() is only called iff a non-root new_user is given:
>> [...]
>> Why is the setsid() call dependent on the user?
> 
> First of all, this is a really nasty (mis-)feature. Introduced due to
> abuse of su for things it shouldn't be used for in the first place.
> The attack scenario are e.g. package %post scripts that execute commands
> on behalf of some unprivileged daemon user. If such an account got
> compromised the attacker might escalate privileges to root e.g. when
> root installs updates for the daemon in question.
> setsid() prevents injecting characters into the tty input buffer of root
> in this case.
> This kind of attack doesn't make sense if the target user is root as
> that would mean the root account is compromised already.

Thanks for the fast explanation.

Have a nice day,
Berny

