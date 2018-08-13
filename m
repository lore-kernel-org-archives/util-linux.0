Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.134]:40154 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMXlA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Aug 2018 19:41:00 -0400
Subject: Re: su(1) --whitelist-environment
To: Bruce Dubbs <bruce.dubbs@gmail.com>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org
References: <20180810092401.inc32ady3eidzyjo@ws.net.home>
 <a745a526-dbc9-ce04-ec4b-8e46d07b8774@gmail.com>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <745f75b6-d849-a519-7855-9de62d999e06@bernhard-voelker.de>
Date: Mon, 13 Aug 2018 22:57:01 +0200
MIME-Version: 1.0
In-Reply-To: <a745a526-dbc9-ce04-ec4b-8e46d07b8774@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/10/2018 11:06 PM, Bruce Dubbs wrote:
> I think it is unnecessary.  su itself does not need the environment 
> variable.  If a user needs a specific setting, then set it in a script:
> 
> su --command myscript

I'm 50:50.  The point was to pass in variables values per environment
to a process inside 'su' (or 'sudo'), and one can achieve that with e.g.

  $ su -c 'env VAR="val" myscript' user

Well, this might become slightly trickier with real shell or environment
variables wrt/ correct shell quoting:

  $ VAR='some value'
  $ su -c 'env VAR="'"$VAR"'" myscript' user

It might be worth adding such an example to the documentation.

Have a nice day,
Berny
