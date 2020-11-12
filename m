Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FC0C2D0A3
	for <util-linux@archiver.kernel.org>; Thu, 12 Nov 2020 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22BD22240
	for <util-linux@archiver.kernel.org>; Thu, 12 Nov 2020 14:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLOW4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOW4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 12 Nov 2020 09:22:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FFCC0613D1
        for <util-linux@vger.kernel.org>; Thu, 12 Nov 2020 06:22:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1kdDV0-0008Cq-T1
        for util-linux@vger.kernel.org; Thu, 12 Nov 2020 15:22:54 +0100
Message-ID: <79d4b61aad5d2d3f29cfd56cd9c6c1a552f5d4bf.camel@pengutronix.de>
Subject: Licensing Issue with lib/signames.c
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     util-linux@vger.kernel.org
Date:   Thu, 12 Nov 2020 15:22:54 +0100
Organization: Pengutronix e.K.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: util-linux@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

during a licensing scan it was noticed that the codefile lib/signames.c
contains a BSD-4-Clause-UC license. To my understanding this makes it
incompatible to be linked with GPL Licensed Parts of util-linux. IANAL
of course. This is also noted in the lib/Makemodule.am:
  #
  # Use only LGPL or Public domain (preferred) code in libcommon, otherwise add
  # your lib/file.c directly to the _SOURCES= of the target binary.
  #
AFAICS this was introduced in 6855f6e80bfe ("kill: Extract signal names
into signames.h/signames.c").

Regards,
Rouven Czerwinski

