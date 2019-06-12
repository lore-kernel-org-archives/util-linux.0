Return-Path: <SRS0=WFtY=UL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6883C31E46
	for <util-linux@archiver.kernel.org>; Wed, 12 Jun 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5D1208CA
	for <util-linux@archiver.kernel.org>; Wed, 12 Jun 2019 13:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408443AbfFLNkK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407111AbfFLNkK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 12 Jun 2019 09:40:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5A358667E;
        Wed, 12 Jun 2019 13:40:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F12B039B9;
        Wed, 12 Jun 2019 13:40:08 +0000 (UTC)
Date:   Wed, 12 Jun 2019 15:40:05 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [RFC] utility for SED management
Message-ID: <20190612134005.cb7m2qhgf2aolrf6@ws.net.home>
References: <548EA37F71F6AC4BB746F459732504FF7F1810E3@FMSMSX119.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548EA37F71F6AC4BB746F459732504FF7F1810E3@FMSMSX119.amr.corp.intel.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 13:40:09 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 11, 2019 at 06:30:51AM +0000, Jakowski, Andrzej wrote:
> We have built prototype code covering these functionalities and now we would
> like to productize it. We are looking for the right place to publish our SW,
> considering util-linux project as one of the options. The SW will likely
> consist of:
>  * Libsed - shared object exposing programmatic interface for security
>    management (Opal) of disk
>  * Sedcli - command line utility covering both client and data center flows.
>    Sedcli will use libsed for interaction with the drive, libkmip for
>    interaction with OASIS KMIP based key manager and tpm2-tss to interact with
>    TPM2 key manager
>  * Udev rules - will be used to invoke sedcli to auto-provision or auto-unlock
>    when new device is added to the OS (e.g. hot insert)
>  * System.d  scripts - will be used to invoke sedcli when key needs to be 
>    retrieved from network attached key manager
>  * Config file - will define policies for example on which disk should be 
>    security managed or not
> 
> We would like to contribute that SW into util-linux project. What do you think
> about adding this SW into util-linux?

From my point of view (and maybe I'm wrong ;-)) it seems complex
enough to keep it as an independent stand-alone project ("sed-utils").
Not sure if it makes sense to push it to generic util-linux package.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
