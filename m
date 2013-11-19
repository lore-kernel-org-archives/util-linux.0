Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44263 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab3KSNje (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Nov 2013 08:39:34 -0500
Date: Tue, 19 Nov 2013 14:39:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Martin Schmid <scm@aps-systems.ch>
Cc: util-linux@vger.kernel.org
Subject: Re: RFQ: changes on ldattach.c for GSM710 discipline
Message-ID: <20131119133924.GH5572@x2.net.home>
References: <52863868.9080806@aps-systems.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52863868.9080806@aps-systems.ch>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 15, 2013 at 04:06:16PM +0100, Martin Schmid wrote:
> I'm just preparing for some add-ons and wanted to check if someone else is
> working on it and if my ideas are not too far away from what is the
> intention of the tool.
> 
> I'd like to add support for N_GSM710 that comes with the kernel module
> n_gsm. Someone else ('guowenxue') has already brought a slightly patched
> version into the wild which is too restricted and specific.
> 
> The planned features are:
> 
> - setting the GSM710 discipline
> - sending a configurable string out (parameter '--mux' or '-m', default
> AT+CMUX=0)
> - configurable pause in seconds after the command (parameter '--pause' or
> -p)
> - UUCP lock file support (-l or --lock, default none,
> '/var/lock/<devicename>' if no argument is given)

 Please, don't send one huge patch - split it per-feature.

 Do we really need support for the locks? There is lockdev(3)
 (although it seems currently unmaintained).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
