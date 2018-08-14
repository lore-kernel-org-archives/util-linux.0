Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728272AbeHNMTX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Aug 2018 08:19:23 -0400
Date: Tue, 14 Aug 2018 11:32:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Subject: Re: su(1) --whitelist-environment
Message-ID: <20180814093257.nglcor4c3jagjyxv@ws.net.home>
References: <20180810092401.inc32ady3eidzyjo@ws.net.home>
 <a745a526-dbc9-ce04-ec4b-8e46d07b8774@gmail.com>
 <745f75b6-d849-a519-7855-9de62d999e06@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <745f75b6-d849-a519-7855-9de62d999e06@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 13, 2018 at 10:57:01PM +0200, Bernhard Voelker wrote:
> On 08/10/2018 11:06 PM, Bruce Dubbs wrote:
> > I think it is unnecessary.  su itself does not need the environment 
> > variable.  If a user needs a specific setting, then set it in a script:
> > 
> > su --command myscript

The important is to say that reset environment is good, expected and
wanted thing. You want to have full control on environment in many
cases.

> I'm 50:50.  The point was to pass in variables values per environment
> to a process inside 'su' (or 'sudo'), and one can achieve that with e.g.

BTW, sudo has env_check, env_delete, or env_keep to control environment
in the sudoers.

>   $ su -c 'env VAR="val" myscript' user
> 
> Well, this might become slightly trickier with real shell or environment
> variables wrt/ correct shell quoting:
> 
>   $ VAR='some value'
>   $ su -c 'env VAR="'"$VAR"'" myscript' user

Well, probably usable way for scripts, but ugly for users on command line.

All the idea behind the patch is make things more user-friendly

    su -w GREP_COLOR,COLORFGBG - kzak

seems better than assume -c 'env VAR ..."

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
