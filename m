Return-Path: util-linux-owner@vger.kernel.org
Received: from mail216.messagelabs.com ([85.158.143.99]:41422 "HELO
	mail216.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754662Ab1FNMSa convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jun 2011 08:18:30 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Tue, 14 Jun 2011 14:17:11 +0200
Subject: RE: [PATCH] uuidgen: print warning if uuidd isn't running
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A088075359D@MCHP058A.global-ad.net>
References: <1307540101-6376-1-git-send-email-ludwig.nussel@suse.de>
 <20110614114534.GF14293@nb.net.home> <20110614115125.GG14293@nb.net.home>
 <201106141406.10364.ludwig.nussel@suse.de>
In-Reply-To: <201106141406.10364.ludwig.nussel@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ludwig Nussel wrote:
> Karel Zak wrote:
>
> Well, who reads docu if uuidgen -t appears to work?
> 
>>  ... we can also add a new option (e.g. --safe) to use 
>>  uuid_generate_time_safe().
> 
> ... or make -t fail if it's not safe and add a --unsafe option. That
> would be the fail-safe approach :-)

Wasn't there a similar discussion back in Feb. when the *_safe()
function was introduced?
http://www.spinics.net/lists/util-linux-ng/msg03933.html
http://www.spinics.net/lists/util-linux-ng/msg04092.html


Bye,
Berny
