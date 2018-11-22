Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A85BC43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 11:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3547F20672
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 11:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3547F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fatal.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeKVWWS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:22:18 -0500
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:56206 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeKVWWR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Nov 2018 17:22:17 -0500
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 1A436247A5; Thu, 22 Nov 2018 12:43:13 +0100 (CET)
Date:   Thu, 22 Nov 2018 12:43:13 +0100
From:   Andreas Henriksson <andreas@fatal.se>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC/PATCH] Add hardening settings to uuidd.service
Message-ID: <20181122114313.2n37c6zkl3zjsxty@fatal.se>
References: <20181112211031.21996-1-andreas@fatal.se>
 <20181122103219.atqj725ahcqg2n7p@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122103219.atqj725ahcqg2n7p@ws.net.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Nov 22, 2018 at 11:32:19AM +0100, Karel Zak wrote:
> Not sure, maybe I have miss some another your patch or you forgot to
> send any patch, [...]

Yeah, I already noticed my screwup here .... Don't have the git tree
available right now but will send a v2 (with the submitted
fixup squashed into previous change) ASAP.

Sorry for not looking properly on what I actually submitted.

Regards,
Andreas Henriksson
