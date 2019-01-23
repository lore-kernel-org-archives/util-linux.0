Return-Path: <SRS0=H3Yc=P7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750DCC282C0
	for <util-linux@archiver.kernel.org>; Wed, 23 Jan 2019 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F72A21872
	for <util-linux@archiver.kernel.org>; Wed, 23 Jan 2019 17:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfAWRaE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:30:04 -0500
Received: from [195.159.176.226] ([195.159.176.226]:60940 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWRaE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Jan 2019 12:30:04 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcuu-util-linux-ng-2@m.gmane.org>)
        id 1gmMLi-000BzK-Gy
        for util-linux@vger.kernel.org; Wed, 23 Jan 2019 18:30:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     util-linux@vger.kernel.org
From:   "Nuno Silva" <nunojsilva@ist.utl.pt>
Subject: cal: lack of color support disables "standout mode"
Date:   Wed, 23 Jan 2019 09:05:41 +0000
Message-ID: <q29ap5$86n0$1@ciao.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

The cal utility seems to check for color support in the current $TERM in
order to turn standout mode on or off. This means that, in a monochrome
terminal, the current/requested day is not highlighted, even if the
terminal has standout mode defined.

While I can force this with --color=always, I'd say it's slightly
confusing that the highlighting is controlled by --color=. If this
behaviour is kept, perhaps the man page could say something about this?

-- 
Best regards,
Nuno Silva

