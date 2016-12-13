Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932899AbcLMLoY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Dec 2016 06:44:24 -0500
Date: Tue, 13 Dec 2016 12:44:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161213114423.nxqxezd6movgqf4x@ws.net.home>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <20161020151948.3y47rv5lwmqppubf@ws.net.home>
 <20161210171510.GH10558@vapier.lan>
 <201612121501.57462.sweet_f_a@gmx.de>
 <20161212142834.jnspem6oeqqbly4g@ws.net.home>
 <20161212182735.GQ10558@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161212182735.GQ10558@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 12, 2016 at 01:27:35PM -0500, Mike Frysinger wrote:
> 	m4_define([SUFFIX], m4_translit($1, [a-z], [A-Z]))
> 	...
> 	AC_CHECK_TOOL(SUFFIX[]6_CONFIG, suffix[]6-config)
> 	if AC_RUN_LOG($SUFFIX[]6_CONFIG --version ....

 Good point, implemented. Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
