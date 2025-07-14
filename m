Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8949221F17
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495093; cv=none; b=B2+zkzaDU5Yvfp6mo+sSNpFdTzN+5ADgMvNo/9WA8Psa+5IwjwrjiIJBim7NX8CJg0mkhm5zEa3Ffv71Dcdbp1j/qMZMl1Jwtky1FfNGqia9E8kFyMHW/AeSDld/w6SRlKDAIMF2j/KvLhVL7YCx9uyWP0O808ZKbIDox92c8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495093; c=relaxed/simple;
	bh=xd4PHOi7RafXLfixJtexQL6QUAoFuKZGGUNbTN+Brxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0sfcN3ufneBA32HpC+jtiRVa7lLp4oIHAyQc1y+ewau5pBrJ6asotnVc+/F8CwyJ9ja2wIAZ4pYAZFvgVlyqIQLhVQDNRsMA+hfMAiC6mbwMKHYY8bBAbe2EFb0ocJ51C0UwpyuPCxgVxiGI9gC1tQLQDi8T9kLKAhWrcHL/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUxOIM/x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUxOIM/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752495089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0QUurPFxOrhFKcoCTK5XyTxGPFZBgYrq7WENPxPhOk=;
	b=CUxOIM/xlpsyzLj4bvqRVmXdugmWME1th94J2v5jgK0q5qDaPJQ1359FbzQvwM2GYLF+TW
	11wxFej+CNphjUMM/mwQrPwUQO/6zFwPovvravPrWWU+BDE60d2TxZZkgcKTKm2Uln6IIn
	QuI657SDrjV2iC0bhdCmQ3nkrjdfOXc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-GLBxfyzDMFmlKpW4meDdtQ-1; Mon,
 14 Jul 2025 08:11:26 -0400
X-MC-Unique: GLBxfyzDMFmlKpW4meDdtQ-1
X-Mimecast-MFC-AGG-ID: GLBxfyzDMFmlKpW4meDdtQ_1752495085
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 638551956087;
	Mon, 14 Jul 2025 12:11:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.225])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62949197702C;
	Mon, 14 Jul 2025 12:11:24 +0000 (UTC)
Date: Mon, 14 Jul 2025 14:11:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Paul Benoit <paul@os.amperecomputing.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lscpu-arm: Allow externally sourced model name.
Message-ID: <orijvbt7r27kydrga2fq74hk7r4goizmbtqfqlbqngkpyizbod@xhwyidk2u3zh>
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711211648.53361-1-paul@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


Hi Paul,

On Fri, Jul 11, 2025 at 02:16:47PM -0700, Paul Benoit wrote:
> When there isn't an entry for the model name in the id_part table(s),
> attempt to get the machine name from /sys/bus/soc/devices/soc0/machine

How is it supposed to work on a system with multiple CPU types (more CPU  
models) if it reads all from the same path?

> +	/*
> +	 * If the Model name was not found in the lscpu 'id_part' tables, see
> +	 * if there is a Machine name associated with the SOC.  This name may
> +	 * have been set via either SOC specific support code, or obtained
> +	 * via an ARM SMC CC call into Trusted Firmware.
> +	 */
> +	if (!ct->modelname) {
> +		fd = ul_path_fopen(NULL, "r", _PATH_SOC_MACHINENAME);
> +		if (fd) {
> +			if (!fgets(machinename, sizeof(machinename), fd))
> +				machinename[0] = '\0';
> +			fclose(fd);
> +
> +			/* Replace newline with string terminator */
> +			for (i = 0; i < strlen(machinename); i++) {
> +				if (machinename[i] == '\n')
> +					machinename[i] = '\0';
> +			}
> +
> +			if (strnlen(machinename, sizeof(machinename)))
> +				ct->modelname = xstrdup(machinename);

    if (!ct->modelname)
        ul_path_read_string(NULL, &ct->modelname, _PATH_SOC_MACHINENAME);

This should be enough, it reads the string, removes \n and strdup()
the result.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

