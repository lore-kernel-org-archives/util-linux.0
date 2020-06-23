Return-Path: <SRS0=LABb=AE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C22C433DF
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0235F20723
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbgFWO4l convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31650 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732981AbgFWO4k (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Jun 2020 10:56:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-1Tcx-OGiMOmrOBxgl3ygmw-1; Tue, 23 Jun 2020 10:56:36 -0400
X-MC-Unique: 1Tcx-OGiMOmrOBxgl3ygmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 011CB804008;
        Tue, 23 Jun 2020 14:56:35 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7DD35BAE5;
        Tue, 23 Jun 2020 14:56:33 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>, "Dmitry V. Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH 0/2] setarch: add arm and aarch64 architectures to transition
Date:   Tue, 23 Jun 2020 16:56:18 +0200
Message-Id: <20200623145620.2669920-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Since aarch64 kernel can be configured with compat 32-bit support
enabled, extend translation rules in a way similar to x86/x86_64.

Alexey Gladkov (2):
  setarch: make verify_arch_domain extendable
  setarch: add arm and aarch64 architectures to transition rules

 sys-utils/setarch.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

-- 
2.25.4

