Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF90C433EF
	for <util-linux@archiver.kernel.org>; Tue, 19 Apr 2022 11:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350906AbiDSLQc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiDSLQb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2022 07:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09B9B2B241
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2022 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650366828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9Qdi3X/ahhXpoaafFIpFpFH/UX5dAnnmYINtuCTVVs=;
        b=S2SV73XmJAvBSmUIxak0ErFsu6q8ImYCsqFQ94PgeUbuT+F9EkYbzn1UekL0AJcetrDmL7
        O1zB4bOWzyjToQWgI7FHL4A4Zy7ETFHLLKlloBhQISUs/tLQ6NXiW7nBbsfb1KPdIk/IOV
        VhifoP9oHtLAW+JaApwdW4FGA74ECyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-eVIKbRfJMquEx9muPRrkjw-1; Tue, 19 Apr 2022 07:13:44 -0400
X-MC-Unique: eVIKbRfJMquEx9muPRrkjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4C521014A60;
        Tue, 19 Apr 2022 11:13:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B293145F950;
        Tue, 19 Apr 2022 11:13:43 +0000 (UTC)
Date:   Tue, 19 Apr 2022 13:13:41 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC v2] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220419111341.7n2jhxlf4446rmle@ws.net.home>
References: <20220406113814.twdo4mwkevwuayht@ws.net.home>
 <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 07, 2022 at 08:39:13PM +0200, наб wrote:
> Thanks for the pointers!

Some other notes (sorry) ;)

> diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
> index f09e68860..13209d861 100644
> --- a/libmount/src/context_mount.c
> +++ b/libmount/src/context_mount.c
> @@ -1020,6 +1020,132 @@ static int do_mount_by_pattern(struct libmnt_context *cxt, const char *pattern)
>  	return rc;
>  }
>  
> +/* Extracted from mnt_optstr_get_uid() */
> +static int parse_ugid(const char *value, size_t valsz, unsigned *uid)

Can you move it to libmount/src/utils.c as mnt_parse_uid() and mnt_parse_gid() ?

And use mnt_parse_uid() in libmount/src/optstr.c:mnt_optstr_get_uid()?

It would be nice to have only one place (code) where we convert string
to uid (or gid).

Later we can re-use these functions for ID-mapping patches too.

In this case it would be nice to be strict and use uid_t and gid_t in
the functions.

We already had CVE for this code, so I'd like to be paranoid here :-)

> +{
> +	char buf[sizeof(stringify_value(UINT64_MAX))];
> +	int rc;
> +	uint64_t num;
> +
> +	assert(value);
> +	assert(uid);
> +
> +	if (valsz > sizeof(buf) - 1) {
> +		rc = -ERANGE;
> +		goto fail;
> +	}
> +	mem2strcpy(buf, value, valsz, sizeof(buf));
> +
> +	rc = ul_strtou64(buf, &num, 10);
> +	if (rc != 0) {
> +		errno = ENOENT;
> +		goto fail;
> +	}
> +	if (num > ULONG_MAX || (unsigned) num != num) {

 || (uid_t) num != num

for mnt_parse_uid() and

 || (gid_t) num != num

for mnt_parse_gid()

> +		errno = ERANGE;
> +		goto fail;
> +	}
> +	*uid = (unsigned) num;
> +
> +	return 0;
> +fail:
> +	DBG(UTILS, ul_debug("failed to convert '%.*s' to number [errno=%d]", (int) valsz, value, errno));
> +	return -1;
> +}
> +
> +static int parse_mode(const char *value, size_t valsz, mode_t *uid)

Let's also introduce libmount/src/optstr.c:mnt_parse_mode() to be
consistent.

...

> +/*
> + * Process X-mount.owner=, X-mount.group=, X-mount.mode=.
> + */
> +static int parse_ownership_mode(struct libmnt_context *cxt)
> +{
> +	int rc;
> +
> +	const char *o = mnt_fs_get_user_options(cxt->fs);
> +	if (!o)
> +		return 0;
> +
> +	char *owner;
> +	size_t owner_len;

Please, please, define variables at the beginning of the code block.

> +	if ((rc = mnt_optstr_get_option(o, "X-mount.owner", &owner, &owner_len)) < 0) {
> +		return -MNT_ERR_MOUNTOPT;}
> +	if (!rc) {
> +		if (!owner_len)
> +			return errno = EINVAL, -MNT_ERR_MOUNTOPT;
> +
> +		char *owner_tofree = NULL;

here too

> +		rc = mnt_get_uid(owner[owner_len] ? (owner_tofree = strndup(owner, owner_len)) : owner, &cxt->tgt_owner);
> +		free(owner_tofree);
> +		if (cxt->tgt_owner == (uid_t) -1 && isdigit(*owner))
> +			rc = parse_ugid(owner, owner_len, &cxt->tgt_owner);
> +		if (rc)
> +			return -MNT_ERR_MOUNTOPT;
> +	}
> +
> +	char *group;
> +	size_t group_len;

here too

> +	if ((rc = mnt_optstr_get_option(o, "X-mount.group", &group, &group_len)) < 0)
> +		return -MNT_ERR_MOUNTOPT;
> +	if (!rc) {
> +		if (!group_len)
> +			return errno = EINVAL, -MNT_ERR_MOUNTOPT;
> +
> +		char *group_tofree = NULL;

here too

> +		rc = mnt_get_uid(group[group_len] ? (group_tofree = strndup(group, group_len)) : group, &cxt->tgt_group);
> +		free(group_tofree);
> +		if (cxt->tgt_group == (uid_t) -1 && isdigit(*group))
> +			rc = parse_ugid(group, group_len, &cxt->tgt_group);
> +		if (rc)
> +			return errno = ENOENT, -MNT_ERR_MOUNTOPT;
> +	}
> +
> +	char *mode;
> +	size_t mode_len;

here too

> +	if ((rc = mnt_optstr_get_option(o, "X-mount.mode", &mode, &mode_len)) < 0)
> +		return -MNT_ERR_MOUNTOPT;
> +	if (!rc) {
> +		if (!mode_len)
> +			return errno = EINVAL, -MNT_ERR_MOUNTOPT;
> +		if ((rc = parse_mode(mode, mode_len, &cxt->tgt_mode)))
> +			return -MNT_ERR_MOUNTOPT;
> +	}
> +
> +	DBG(CXT, ul_debugobj(cxt, "ownership %d:%d, mode %04o", cxt->tgt_owner, cxt->tgt_group, cxt->tgt_mode));
> +
> +	return 0;
> +}
> +
>  /**
>   * mnt_context_prepare_mount:
>   * @cxt: context
> @@ -1064,6 +1190,8 @@ int mnt_context_prepare_mount(struct libmnt_context *cxt)
>  		rc = mnt_context_guess_fstype(cxt);
>  	if (!rc)
>  		rc = mnt_context_prepare_target(cxt);
> +	if (!rc)
> +		rc = parse_ownership_mode(cxt);
>  	if (!rc)
>  		rc = mnt_context_prepare_helper(cxt, "mount", NULL);
>  
> @@ -1089,6 +1217,21 @@ end:
>  	return rc;
>  }
>  
> +static int set_ownership_mode(struct libmnt_context *cxt)
> +{
> +	const char *target = mnt_fs_get_target(cxt->fs);
> +
> +	if (cxt->tgt_owner != (uid_t) -1 || cxt->tgt_group != (uid_t) -1)

Please, add here some debug message,

> +		if (lchown(target, cxt->tgt_owner, cxt->tgt_group) == -1)
> +			return -MNT_ERR_CHOWN;
> +
> +	if (cxt->tgt_mode != (mode_t) -1)

and here too.

> +		if (chmod(target, cxt->tgt_mode) == -1)
> +			return -MNT_ERR_CHMOD;
> +
> +	return 0;
> +}
> +
>  /**
>   * mnt_context_do_mount
>   * @cxt: context
> @@ -1191,6 +1334,9 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
>  	if (mnt_context_is_veritydev(cxt))
>  		mnt_context_deferred_delete_veritydev(cxt);
>  
> +	if (!res)
> +		res = set_ownership_mode(cxt);
> +
>  	if (!mnt_context_switch_ns(cxt, ns_old))
>  		return -MNT_ERR_NAMESPACE;
>  
> @@ -1841,7 +1987,18 @@ int mnt_context_get_mount_excode(
>  			if (buf)
>  				snprintf(buf, bufsz, _("filesystem was mounted, but failed to switch namespace back"));
>  			return MNT_EX_SYSERR;
> +		}
>  
> +		if (rc == -MNT_ERR_CHOWN) {
> +			if (buf)
> +				snprintf(buf, bufsz, _("filesystem was mounted, but failed to change ownership to %u:%u: %m"), cxt->tgt_owner, cxt->tgt_group);
> +			return MNT_EX_SYSERR;
> +		}
> +
> +		if (rc == -MNT_ERR_CHMOD) {
> +			if (buf)
> +				snprintf(buf, bufsz, _("filesystem was mounted, but failed to change mode to %04o: %m"), cxt->tgt_mode);
> +			return MNT_EX_SYSERR;
>  		}

Yes, this is probably the best solution.

Thanks for your work. (Don't forget Signed-off-by:)

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

