Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:43767 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab2FFMlk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Jun 2012 08:41:40 -0400
Message-ID: <4FCF4FFD.70204@suse.de>
Date: Wed, 06 Jun 2012 14:41:33 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: su: calling setsid() for -c only if non-root user?
References: <4FCF441C.1090400@bernhard-voelker.de>
In-Reply-To: <4FCF441C.1090400@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bernhard Voelker wrote:
> I am playing around with the --command and --session-command options of su,
> and I noticed that setsid() is only called iff a non-root new_user is given:
> [...]
> Why is the setsid() call dependent on the user?

First of all, this is a really nasty (mis-)feature. Introduced due to
abuse of su for things it shouldn't be used for in the first place.
The attack scenario are e.g. package %post scripts that execute commands
on behalf of some unprivileged daemon user. If such an account got
compromised the attacker might escalate privileges to root e.g. when
root installs updates for the daemon in question.
setsid() prevents injecting characters into the tty input buffer of root
in this case.
This kind of attack doesn't make sense if the target user is root as
that would mean the root account is compromised already.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
