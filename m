Return-Path: <SRS0=EzkW=RO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3CAC43381
	for <util-linux@archiver.kernel.org>; Mon, 11 Mar 2019 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8632087C
	for <util-linux@archiver.kernel.org>; Mon, 11 Mar 2019 22:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nGGn0Ors"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCKWBP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:01:15 -0400
Received: from mx.treblig.org ([46.43.15.161]:56672 "EHLO mx.treblig.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKWBP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 11 Mar 2019 18:01:15 -0400
X-Greylist: delayed 2408 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 18:01:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=otsW0qtatXfpzL5xTzVv4JQxi+EEfSuWTtLO9uUmQPw=; b=nGGn0OrsQyco1KVDdD55Py7Uyj
        EB61GD8ucEJqi/vuspu0nEA27zUepJF4kMLfufiOBO79TrfLGzkoj+GwRQ4r/Ip3FMLTLrZvqtA/0
        q1SG+yF6HvhGJGW3oseuXtf7rsv1/988aqquYwMCK/nUtPv6vlKvfo1HqUPxNL9t0ws6Kq++qYg55
        PaQSrto3rBKg2lCLFqMwCuweosAQp2pMus8zOzheSfzjbfiLTZbk0sVcG6QtyPMx1nYp8AxtvxvyU
        ZN8iVZFUeRA/wSOfwnXrMtItRTNlOnsZSOIqp0ZUamJR0oCfsXf4Plwc/+3WSQ/BQ2tGPZcvp65ua
        v3UWD5FA==;
Received: from dg by mx.treblig.org with local (Exim 4.89)
        (envelope-from <dg@treblig.org>)
        id 1h3SM5-0007yg-2l; Mon, 11 Mar 2019 21:21:05 +0000
Date:   Mon, 11 Mar 2019 21:21:04 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     L A Walsh <lkml@tlinx.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: does util-linux have a 'report sector size' util?
Message-ID: <20190311212104.edekhgctqto37tn7@gallifrey>
References: <5C86CBA1.40802@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C86CBA1.40802@tlinx.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/4.9.0-6-amd64 (x86_64)
X-Uptime: 21:20:16 up 217 days,  2:19,  1 user,  load average: 0.04, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

* L A Walsh (lkml@tlinx.org) wrote:
> 
> Trying to track down why my 4K drives no longer display 4K
> in sysfs (/sys) and don't seem to show individual disk
> drive information.  When I first got the drives, linux displayed
> the correct physical disk size, but when I look now, I only
> see 512. 
> 
> I just checked with MegaCLI, and it can still display all
> the data (harddisk manuf. in each bah, and physical sector size).
> 
> So I'm wonder if util-linux has something in its blk library
> about this?

Is this one of the PHY-SEC or LOG-SEC fields that lsblk can print?

[dg@major ~]$ lsblk -o "NAME,PHY-SEC,LOG-SEC"
NAME                                            PHY-SEC LOG-SEC
sda                                                 512     512

Dave

> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
