Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776CC433F5
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 15:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiDFPYK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiDFPXe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 11:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE4A84822C6
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649247840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqMpnkh4L64Eq1cMr/dsNixArWmDrXQ8VzAMWgOcTL4=;
        b=ERfK4HZ7PB+Oh7ZihCNokqlLaSls9VJsgthG/u9MWH9f9X8+Q5mt3GIggz9I8Tq2DPHgXX
        qudCjD/qHld6UOcDtxzwmsUmEHNqmoNrYA+zp2j1NczmmPHR6QXuOZmwHF/NbMRjCfqwrt
        24DMOQQhcaOiUIPygPFhkiMj6lDo/rc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-vdhWtThLNNuVTZNqvDNodw-1; Wed, 06 Apr 2022 07:38:23 -0400
X-MC-Unique: vdhWtThLNNuVTZNqvDNodw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18185100BAA6;
        Wed,  6 Apr 2022 11:38:23 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC7140D1B98;
        Wed,  6 Apr 2022 11:38:19 +0000 (UTC)
Date:   Wed, 6 Apr 2022 13:38:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220406113814.twdo4mwkevwuayht@ws.net.home>
References: <20220330181300.mr66k4zghcrf4l6c@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330181300.mr66k4zghcrf4l6c@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 30, 2022 at 08:13:00PM +0200, наб wrote:
> Which take an user, group, and mode, respectively, and set them on the
> target after mounting
> 
> This is vaguely similar to tmpfs(5)'s [ug]id= and mode= options,
> but we POSIX-parse the user- and group names
> 
> Oft requested in systemd/zram-generator, since a common use-case
> is to use it to create /tmp or an equivalent directory that needs
> to be a=rwx,o+t (or a user's private temp that needs to be owned
> by them) ‒ this is impossible without terrible hacks, cf.
> https://github.com/systemd/zram-generator/issues/150,
> https://github.com/systemd/zram-generator/issues/146, &c.
> 
> This started off as a Set{User,Group,Mode}= systemd mount unit,
> but was poetterung into libmount options:
> https://github.com/systemd/systemd/pull/22889

I see how usable this feature could be, but it also increases
complexity of the mount(8) command.

> But I'm not sure how to proceed. I've stuffed the parsing and chowning
> stage into mnt_context_finalize_mount() for ease-of-PoC, but should:
>   (a) the post-syscall error handling in mnt_context_get_mount_excode()
>       be extended to recognise MNT_ERR_MOUNTOPT?

Yes, see MNT_ERR_NAMESPACE, it the same thing. We have it in the
pre-syscall and in post-syscall sections.

>   (b) the parsing/chowning stages be split (parsing in pre-mount prep,
>       chowning in post-mount)? with a new MNT_ERR_ flag potentially?

Yes, this is probably the most robust way (don't call mount syscall if
X-mount.* is invalid).

I guess you can add tgt_owner, tgt_group and tgt_mode to libmnt_context to
keep parsed results, fill the fields in mnt_context_prepare_mount() (or so) and use
it mnt_context_do_mount() (before mnt_context_switch_ns()).

Don't forget to reset it in mnt_reset_context().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

