Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396B227EB0
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648341; cv=none; b=ih43hmR2cfW/mHw8eAUWOZvB6RoWRvOTIZ/ZXAlFT8V7o8+wnYgea0l9JdnVCJxf9kCPdJmoXFEc4E6lfGpU/UkYLrM4nUNsaxhIC6ZfnSJvsuBJ4Yd/u5jlya7yy5dTK0lWCR4BR4Hru5i/RN8pIGhDYE/3rTtCU3jpuBOJY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648341; c=relaxed/simple;
	bh=PbSBjpaJUTORz/U3VQnj6Kf6ZUfPVIpD35PYp/pCjb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ8BHFrp0yEWjZ8nni7tuN5Rx0KWvw+RRyMJiEvqA4tRuw9WWeWZkURI3du46Py8IHX1egrM1gkG8remCUzBr9Nc0kh6ZSotIyc6Uf4ggqo0bXthPGOkJ9uforxEDDCyLevIDKkcHEnxdFUQKjy3Ffa50JozsQoE/8dZJN8g1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMTB1kH+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMTB1kH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740648338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKHxZrFyajshoOr26cYqRyzdq9IukZt+y/xk6wdKri4=;
	b=SMTB1kH+h8/AtpEruCNSdnt/yHwpVs/G9ZH3rK+/Ob0Fbata5WMKXXucuOM+F/OygXAFr5
	KKp7UT4HMJIX36tRo65kw+9jm1HrYyjCcQiEW5j3D8LkYbLMFyt3hiOpY1KIKu4l+GQKJx
	HksDpFiQaHHmykUMDC4gxAmVHVeoJUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-9L41V8rON4WiKR0DbHpJWw-1; Thu,
 27 Feb 2025 04:25:32 -0500
X-MC-Unique: 9L41V8rON4WiKR0DbHpJWw-1
X-Mimecast-MFC-AGG-ID: 9L41V8rON4WiKR0DbHpJWw_1740648331
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41C761954B1E;
	Thu, 27 Feb 2025 09:25:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E776300018D;
	Thu, 27 Feb 2025 09:25:29 +0000 (UTC)
Date: Thu, 27 Feb 2025 10:25:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] irqtop: add batch mode support
Message-ID: <3cip52rtte72zolbb2ta6ztl63p4ez7oo2wmi5fpqvjxz45jwk@akiqt56yf4vs>
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-2-joe.jin@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227044916.89925-2-joe.jin@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Feb 26, 2025 at 08:49:14PM GMT, Joe Jin wrote:
> +#define irqtop_batch_mode(ctl) ((ctl)->batch == true)

Do we need this macro? I think use

 if (ctl->batch)
   ...
or

 if (!ctl->batch)
   ...

in the code is good enough.

> +#define irqtop_printf(ctl, fmt, args...)		\
> +	do { 						\
> +		if (irqtop_batch_mode(ctl))		\
> +			fprintf(stdout, fmt, ##args);	\
> +		else {					\
> +			wprintw(ctl->win, fmt, ##args);	\
> +		}					\
> +	}while(0)

It would be more robust to use an inline function with vw_printw() and
vfprintf() rather than a macro with a variadic number of arguments, or
use __VA_ARGS__ in the macro.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

