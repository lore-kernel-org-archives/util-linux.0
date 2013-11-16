Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:48670 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642Ab3KPKfF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 16 Nov 2013 05:35:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1VhdDU-0008LN-1y
	for util-linux@vger.kernel.org; Sat, 16 Nov 2013 11:35:04 +0100
Received: from nemi.mork.no ([148.122.252.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 16 Nov 2013 11:35:04 +0100
Received: from bjorn by nemi.mork.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 16 Nov 2013 11:35:04 +0100
To: util-linux@vger.kernel.org
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: RFQ: changes on ldattach.c for GSM710 discipline
Date: Sat, 16 Nov 2013 11:28:28 +0100
Message-ID: <87fvqwljxv.fsf@nemi.mork.no>
References: <52863868.9080806@aps-systems.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Martin Schmid <scm@aps-systems.ch> writes:

> I'd like to add support for N_GSM710 that comes with the kernel module
> n_gsm. Someone else ('guowenxue') has already brought a slightly
> patched version into the wild which is too restricted and specific.
>
> The planned features are:
>
> - setting the GSM710 discipline

Sounds like a great plan to me.  Just a minor nit:

 "GSM 0710" (or maybe even better: "GSM 07.10") and "N_GSM0710"

"All 3GPP specifications have a specification number consisting of 4 or
5 digits." - ref http://www.3gpp.org/specifications/specification-numbering

You don't want this work confused with GSM 71.0x support when the 3GPP
gets there :-)



Bjørn

