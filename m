Return-Path: <SRS0=5bNd=RW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167E9C43381
	for <util-linux@archiver.kernel.org>; Tue, 19 Mar 2019 07:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27620989
	for <util-linux@archiver.kernel.org>; Tue, 19 Mar 2019 07:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openfortress.nl header.i=rick@openfortress.nl header.b="OnZnw4cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfCSHyB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:54:01 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:36652 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfCSHyB (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Mar 2019 03:54:01 -0400
Received: from popmini.vanrein.org ([83.161.146.46])
        by smtp-cloud7.xs4all.net with ESMTP
        id 69ZJhUFNZLMwI69ZKhaoD7; Tue, 19 Mar 2019 08:53:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openfortress.nl; 
 i=rick@openfortress.nl; q=dns/txt; s=fame; t=1552982024; 
 h=message-id : date : from : mime-version : to : cc : 
 subject : references : in-reply-to : content-type : 
 content-transfer-encoding : date : from : subject; 
 bh=32mRUPWSEb/+arn1U23S5uvJxmEJStM8k/nQO11EJac=; 
 b=OnZnw4clEuxq/hPoJ6xyKnKsTrFVMEPGmKaDRqSQx7BbzpEvC3vf314a
 JaYvgE4fH6oUKx2L6h+Dd1mLfjYG2CsuvXYHTRoSLU0AsF/4RFZBPkMwvS
 orQBIxKBlCBmqPg6voM9MTiDcgooMbqLo5kueFrZo6Cr3BYP92r8K+4dc=
Received: by fame.vanrein.org (Postfix, from userid 1006)
        id 425CC1DF29; Tue, 19 Mar 2019 07:53:17 +0000 (UTC)
Received: from airhead.local (phantom.vanrein.org [83.161.146.46])
        by fame.vanrein.org (Postfix) with ESMTPA id CC1F71DF23;
        Tue, 19 Mar 2019 07:53:05 +0000 (UTC)
Message-ID: <5C909FDF.3040006@openfortress.nl>
Date:   Tue, 19 Mar 2019 08:53:03 +0100
From:   Rick van Rein <rick@openfortress.nl>
User-Agent: Postbox 3.0.11 (Macintosh/20140602)
MIME-Version: 1.0
To:     Fabian.Kirsch@dlr.de
CC:     kzak@redhat.com, util-linux@vger.kernel.org, asbjorn@asbjorn.st
Subject: Re: script(1) plans
References: <20190318125322.4obb27vwtxfuwuie@ws.net.home> <1552980724.5643.12.camel@dlr.de>
In-Reply-To: <1552980724.5643.12.camel@dlr.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.4
X-CMAE-Envelope: MS4wfCZwFeLgBoHwgswS9ek1rafmSBgetLDhiXiHMNH5eLPoSjQYef0IdFcUnLc97vv8krF2RciMF8CFjsmrXs7P2cKYU23aigBqEXvUJXe2LJrjp/Y5ng9Q
 r9h62OrVMcjW5pWFYSkvViOt6dOfQ3apP9MMRVGTvxgQQf6hTYGFxOykv+s+2i47MnlYzULTZfbDhw==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Fabian,

> IMHO strace(1) needs an additional output format which is designed for
> further processing instead of eye-balls.

To that end, I've proposed an output option as a stream, by sending it as stdin to a command.  I am still struggling with some crashes that I haven't been able to resolve yet (mostly lack of time).  Is that the direction you are thinking in?

-Rick
