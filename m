Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58434 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbbDCQio (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Apr 2015 12:38:44 -0400
Message-ID: <1428079098.5647.11.camel@stgolabs.net>
Subject: Re: eject test fails with kernel 3.19
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>
Date: Fri, 03 Apr 2015 09:38:18 -0700
In-Reply-To: <201504031619.38548.sweet_f_a@gmx.de>
References: <201504031619.38548.sweet_f_a@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 2015-04-03 at 15:19 +0100, Ruediger Meier wrote:
> Hi,
> 
> eject(1) fails for scsi_debug module version 1.85 (kernel 3.19).
> 
> The Problem is that command ALLOW_MEDIUM_REMOVAL now returns 
> driverstatus==DRIVER_SENSE with sensecode==0x20 (INVALID COMMAND 
> OPERATION CODE).
> 
> If I ignore that senscode then the other two START_STOP commands finish 
> successfully.
> 
> Should this be fixed in eject(1) or in scsi_debug or is it just a bad 
> idea to eject scsi_debug devices? This documentations says 
> ALLOW_MEDIUM_REMOVAL is supported.
> http://sg.danny.cz/sg/sdebug.html
> 
> I guess the issue came with this kernel commit:

Then the kernel needs fixing. Breaking userspace is a no no, plain and
simple. Who knows what other program(s) might be affected.

Thanks,
Davidlohr

