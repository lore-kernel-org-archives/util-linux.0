Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F921C9F9
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614803; cv=none; b=lSFN3i3t5hzG4MV90IA18RhjVQ9kiTk73frLpEIdmMPCJLOLziT7RDPAHTtp2NajOPii7pZzHgAnP6Sug+UcESl2FV+0kygCuwcJqrcVc2bJnbqPz3UYlUBdcIBB0+Z9Be9TQq0KejsUqVMGk/hjykTOfoxPhCHvVGo81s3oNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614803; c=relaxed/simple;
	bh=nxW5JKN5ACMsQmbqZw4Z/Ftga5aQTM9cNkwfH4S+8jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUUxkMzBeDpttkhbtBSmvxB0p8NwPHdeJ2s1cYfVaxUsUyjwqnMPkRum3kWEz2O1U/1/c+wk9+ZZJhXKRtH7Jcns2v3SuK86ThtKcM9v2TKCux3zrULQrwB8SaroBAluIG6ZAWRPdHjoZvv6ja/HrfRfi5KDfAkNKJNzxHXI3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BChBfOFl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BChBfOFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760614800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLMCPdq5JaSV4UokbbllMMasaiQQBFnoGwkxqwSjnKE=;
	b=BChBfOFlezi+6cgkednTT4UcpiDlpcKIG1qJsdfdmKOrDCYHv9OrBXRhoaL9c1AG6bqkks
	bXHANxJ28BbfMt9dbb7fsL001vYOLDQTnYbAsJFb4K+3GpWvxCbcFVdBZk5tY4ineV+rG9
	E+GuoazrhCT0JV0Q/EthNkqF8uwCPYg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-nFVVgmr8MOy69gmFoLiA-Q-1; Thu,
 16 Oct 2025 07:39:57 -0400
X-MC-Unique: nFVVgmr8MOy69gmFoLiA-Q-1
X-Mimecast-MFC-AGG-ID: nFVVgmr8MOy69gmFoLiA-Q_1760614796
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3766918001DA;
	Thu, 16 Oct 2025 11:39:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 444C1300019F;
	Thu, 16 Oct 2025 11:39:55 +0000 (UTC)
Date: Thu, 16 Oct 2025 13:39:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/6] chmem: add support for dynamic (de)configuration of
 hotplug memory
Message-ID: <atjssajbhhcun7nknnuuz3cvttzw5hhvfvvzkm6ls5aiayxhll@gwzakxqonpob>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
 <20251016101701.552597-4-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016101701.552597-4-sumanthk@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 16, 2025 at 12:16:50PM +0200, Sumanth Korikkar wrote:
> +
> +static int chmem_set_memmap_on_memory(struct chmem_desc *desc, char *name)
> +{
> +	char str[BUFSIZ];
> +	int rc, index;
> +
> +	index = strtou64_or_err(name + 6, _("Failed to parse index"));
> +	idxtostr(desc, index, str, sizeof(str));
> +	rc = ul_path_writef_u64(desc->sysmemconfig, desc->memmap_on_memory,
> +				"%s/memmap_on_memory", name);
> +	if (rc)
> +		warn(_("%s memmap-on-memory failed"), str);
> +	return rc;

It seems that str[BUFSIZ] and idxtostr() are necessary only in case of
an error. How about:

        index = strtou64_or_err(name + 6, _("Failed to parse index"));
        rc = ul_path_writef_u64(desc->sysmemconfig, desc->memmap_on_memory,
            "%s/memmap_on_memory", name);

        if (rc) {
            char str[BUFSIZ];
            idxtostr(desc, index, str, sizeof(str));
            warn(_("%s memmap-on-memory failed"), str);
        }

Note that BUFSIZ seems excessive.

> +static int chmem_config(struct chmem_desc *desc, char *name, int configure)
> +{
> +	int mblock_configured, memmap, rc, index;
> +	char str[BUFSIZ], state[BUFSIZ];
> +
> +	index = strtou64_or_err(name + 6, _("Failed to parse index"));
> +	idxtostr(desc, index, str, sizeof(str));
> +	rc = ul_path_readf_s32(desc->sysmemconfig, &mblock_configured, "%s/config", name);
> +	if (rc)
> +		goto out;
> +	rc = ul_path_readf_s32(desc->sysmemconfig, &memmap, "%s/memmap_on_memory", name);
> +	if (rc)
> +		goto out;
> +	if (mblock_configured) {
> +		if (configure) {
> +			if (chmem_memmap_on_memory_option_enabled(desc) &&

The name is quite long. How about renaming the function to
chmem_memmap_enabled()?

> +					memmap != desc->memmap_on_memory) {
> +				if (!desc->is_size || desc->verbose)
> +					fprintf(stdout,
> +						_("%s must be deconfigured before using -m option\n"), str);
> +				rc = -1;
> +			} else if (desc->is_size) {
> +				/*
> +				 * Allow chmem_onoff_size() to proceed with
> +				 * configuring different memory blocks when the
> +				 * current block is already configured.
> +				 */
> +				rc = -1;
> +			} else if (desc->verbose) {
> +				fprintf(stdout, _("%s already configured\n"), str);
> +			}
> +			goto out;
> +		} else if (ul_path_readf_buffer(desc->sysmem, state,
> +						sizeof(state), "%s/state", name) > 0 &&
> +			   strncmp("online", state, 6) == 0) {
> +			if (!desc->is_size || desc->verbose)
> +				fprintf(stdout, "%s must be offline before deconfiguration\n", str);

Here, the _( ) is missing for the message.

> +		if (!desc->is_size) {
> +			if (configure)
> +				warn(_("%s configure failed\n"), str);
> +			else
> +				warn(_("%s deconfigure failed\n"), str);

It's a detail, but I would suggest a different code pattern:

   warn(configure ? _("%s configure failed") :
                    _("%s deconfigure failed"), str);

 Note that warn() (err(), ...) appends \n to the output, so do not use
 it in the string.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

