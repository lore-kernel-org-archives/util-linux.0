Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D84C433EF
	for <util-linux@archiver.kernel.org>; Wed, 18 May 2022 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiERJqg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 18 May 2022 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiERJqS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 18 May 2022 05:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37517B0D2F
        for <util-linux@vger.kernel.org>; Wed, 18 May 2022 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652867108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59t27MFHgkVRnXqT13xWAu4Ab0IdFUqfto8gIv0WlcA=;
        b=GJ6mfb2cksv+12sfUvjjVMMAj/oz/vLKSFEeWrlwPEP7F+Qu7Y0XJN9QWHmVB9DARDT93G
        xtlMoejNkLaUq9aQkhwAC6A4gy3HhPIG9GaJljNWAP6Xipo321kxgFfWpeVfie1uA6fxO0
        VSdQpT8X33fSogOSvwWMegQ77E/n/MY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-MckFaN2xO66PYoLCpUHelA-1; Wed, 18 May 2022 05:45:04 -0400
X-MC-Unique: MckFaN2xO66PYoLCpUHelA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E11F3C19030;
        Wed, 18 May 2022 09:45:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B19F400D277;
        Wed, 18 May 2022 09:45:03 +0000 (UTC)
Date:   Wed, 18 May 2022 11:45:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Trapp, Michael" <michael.trapp@sap.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: uuidd: Implement continuous clock handling for time based UUIDs
Message-ID: <20220518094501.tdrxnup7buaitrvt@ws.net.home>
References: <20220422100830.32187-1-michael.trapp@sap.com>
 <20220429114607.6ggqozhcir7pp2h2@ws.net.home>
 <F954A285-6204-4317-8295-1EAE38849E83@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F954A285-6204-4317-8295-1EAE38849E83@sap.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 06, 2022 at 02:06:14PM +0000, Trapp, Michael wrote:
> 
> 
> > On 29. Apr 2022, at 13:46, Karel Zak <kzak@redhat.com> wrote:
> > 
> > On Fri, Apr 22, 2022 at 12:08:30PM +0200, Michael Trapp wrote:
> >> +static int get_clock_cont(uint32_t *clock_high,
> >> +			    uint32_t *clock_low,
> >> +			    int num)
> >> +{
> >> +	/* 100ns based time offset according to RFC 4122. 4.1.4. */
> >> +	const uint64_t reg_offset = (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
> >> +	THREAD_LOCAL uint64_t last_clock_reg = 0;
> >> +	uint64_t clock_reg;
> >> +
> >> +	if (last_clock_reg == 0)
> >> +		last_clock_reg = get_clock_counter();
> >> +
> >> +	clock_reg = get_clock_counter();
> >> +	clock_reg += MAX_ADJUSTMENT;
> >> +
> >> +	if ((last_clock_reg + num) >= clock_reg)
> >> +		return -1;
> > 
> > 
> > If I read your code correctly, it initializes the clock at uuidd start
> > and then continues (forever). Each short time of inactivity will
> > increase the difference between time stored in UUIDs and real-time.
> > For example, this difference will be huge for databases where users
> > don't allocate new UUIDs at night.
> > 
> > 
> > Maybe we can implement some hybrid model that resets the continuous
> > clock start point (last_clock_reg) from time to time, for example,
> > every minute (hour, ...). I don't think it will be a performance
> > problem when it does not use LIBUUID_CLOCK_FILE. The result will be
> > UUIDs that match with reality. Does it make sense?
> 
> Of course, we can use a <max_offset_value> as optarg for the ‘-C’ option and update last_clock_reg accordingly.
> A custom value could be set with ‘-C <NUM>’ and the feature could also be deactivated by omitting ‘-C’.
> What do you think about that?

Sounds good.

The question is (from my point of view), do we need fully continuous
(= disconnected) time in uuidd by default for -C? I guess it will be
confusing for UUIDs consumers. Maybe the default should be reset every
N minutes and <max_offset_value> as optional argument to modify it.

 -C                     -- default is reset every N minutes
 -C=<num>               -- overwrite the default
 -C=0 or -C=noreset     -- don't reset

But I have no strong opinion about it, the default could be -C without
reset as well.


Do you plan to use -C for SAP databases? I guess it will resolve all
the performance issues for SAP use-cases.

My plan to keep /var/lib/libuuid/clock.txt in uuidd hands will be
unnecessary (or less important) if -C will be good enough.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

