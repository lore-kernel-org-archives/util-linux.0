Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7470EC4167D
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 12:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbiDLMa2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355639AbiDLM3n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 08:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B212B9B
        for <util-linux@vger.kernel.org>; Tue, 12 Apr 2022 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649763854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RujPEY3r9ArxP9k6MquBT5L6SdcJAd3SmO3+DgDQanI=;
        b=cyvTvFu0ILlDM+VRjnraMnoeYXRib1VDZO9Rbr7vZ6Mh7174q3OgQlCcduhkQ1yCdmxhl/
        JYsU+CCoxBCXqVIbbgZmdaUlDPJ2GRz61Mtg262n/JWxcBuPs5MqQLjQgw45jphp2urgyT
        Y8EBLCF0tFOhOzflnquf1/57FA8+bd8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-yYS02aJkMC2VD5jhFL4IBw-1; Tue, 12 Apr 2022 07:44:10 -0400
X-MC-Unique: yYS02aJkMC2VD5jhFL4IBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60AA4811E7A;
        Tue, 12 Apr 2022 11:44:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D62B145B98A;
        Tue, 12 Apr 2022 11:44:09 +0000 (UTC)
Date:   Tue, 12 Apr 2022 13:44:07 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?QXVyw6lsaWVu?= Lajoie <orel@melix.net>
Cc:     Util-Linux <util-linux@vger.kernel.org>,
        Stanislav Brabec <sbrabec@suse.cz>,
        "Trapp, Michael" <michael.trapp@sap.com>
Subject: Re: libuuid related tasks for next v2.39
Message-ID: <20220412114407.tbosbcffkshdklm4@ws.net.home>
References: <20220401092104.b2snvmahp56zturm@ws.net.home>
 <CAA0A08XAF2eWScVKQ1Jd0vUPfHzZw8PAtiS-jRbom0EvRQ+Zsg@mail.gmail.com>
 <20220412103451.pve2pe3ey3rcxfuq@ws.net.home>
 <CAA0A08VmzKTzFCEqnFP9tw50zgx4iPsif_BktuRSAvfm3hH52w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA0A08VmzKTzFCEqnFP9tw50zgx4iPsif_BktuRSAvfm3hH52w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 12, 2022 at 01:15:56PM +0200, Aurélien Lajoie wrote:
> On Tue, Apr 12, 2022 at 12:35 PM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Fri, Apr 01, 2022 at 11:49:17AM +0200, Aurélien Lajoie wrote:
> > > What about nice helpers to get fast access to the different part of the
> > > uuid?
> >
> > I'm not sure if I understand. What do you mean with the helpers?
> 
> Accessing the different part of the uuid
> version
> time_low
> time_mid
> time_hi_and_version
> clock_seq_hi_and_res clock_seq_low
> node

This is obvious, I'm trying to understand "Accessing". Do you mean
unparse the specified parts or update/set it? For what use-case?

We have something like this for command line (misc-utils/uuidparse.c).

$ uuidparse $(uuidgen --time)
UUID                                  VARIANT TYPE       TIME
970f197e-ba55-11ec-aa93-43a3097bca4a  DCE     time-based 2022-04-12 13:42:11,097843+02:00


Do you mean anything like;

     uuid_time_get_version(uuidstr);
     uuid_time_get_clock_seq()
     ...

or the same but for already parsed uuid (uuid_t)?


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

