Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:59701 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751731Ab1GVI5k convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Jul 2011 04:57:40 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Fri, 22 Jul 2011 10:57:28 +0200
Subject: RE: ionice: requires scheduling since
	7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3AC2@MCHP058A.global-ad.net>
References: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3A66@MCHP058A.global-ad.net>
 <20110722085420.GP22568@nb.net.home>
In-Reply-To: <20110722085420.GP22568@nb.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> I'll improve the behavior:

great!

>  ionice                       : print the current I/O prio.
>  ionice <COMMAND>             : exec command with default (best-effort) class
>  ionice -p PID [...]          : return info about the PID(s)
>  ionice -c CLASS COMMAND      : exec command with the class
>  ionice -c CLASS -p PID [...] : modify PID(s) class
>
> Comments?

   ionice --help                : print help

is missing ;-)

Berny