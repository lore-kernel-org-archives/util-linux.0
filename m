Return-Path: <SRS0=wC18=NL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC9C0044C
	for <util-linux@archiver.kernel.org>; Wed, 31 Oct 2018 09:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16FE2054F
	for <util-linux@archiver.kernel.org>; Wed, 31 Oct 2018 09:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16FE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJaSFQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeJaSFQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 Oct 2018 14:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E43AF307DAAD;
        Wed, 31 Oct 2018 09:08:01 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B67065960;
        Wed, 31 Oct 2018 09:08:00 +0000 (UTC)
Date:   Wed, 31 Oct 2018 10:07:58 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Rtcwake s5 with poweroff
Message-ID: <20181031090758.bsl4jnhfiyf2ijj5@ws.net.home>
References: <CAJx26kWFgTEQ=sMf1Uepw8gor6g7cn6QYeYz34vFyb-uCGDLMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJx26kWFgTEQ=sMf1Uepw8gor6g7cn6QYeYz34vFyb-uCGDLMQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 31 Oct 2018 09:08:01 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Oct 30, 2018 at 03:03:07PM -0700, Justin Chen wrote:
> I have a system that doesn't have "shutdown", instead it uses
> "poweroff". For "rtcwake -m off" (s5), rtcwake sets the wakealarm and
> then issues a shutdown command. I am thinking about putting together a
> patch that will allow rtcwake to use "poweroff". It will first try to
> look for the "shutdown" command and if it is not existent, use
> "poweroff" instead. Are these changes acceptable?

Yes, send patch. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
