Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70235AC17
	for <util-linux@vger.kernel.org>; Mon,  1 Jun 2026 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315847; cv=none; b=HcHMRrW7ZSmVUf9AIf7I3lU1/WcwD2s88wPpfjDhJIBH0PJKyl2pczm7mUH389XSKdtX8Jawn1jheYqrz85hvDegNJqfeO1J5ijFGbYaz/dZjxZfJO5tOBcNQbGCJykZqIAbX3XwT9ALc4icDbsnQe/GFX/+nlC0llOlVKXE+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315847; c=relaxed/simple;
	bh=XDuE9TY1PJWfCZqjMwqhN7CKpXcc69DjeJLudgbV8EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/rcn6KoIPezeUhfV1X2bsesB1d+HNLZeZTyCwxoDjmRb/g7rsUBJrBrjZ3rqPRg4GLU6OKuiFLCQgwMX8S+/77Rdww3Oo+Z8R3vhGUpi/QUQnVFJHTBCykN/xKfXFkLQaOu27MQ3ly2WSRLFbwXzf3yk9r4dYNyIlkB2YC5aWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TopKDxc+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TopKDxc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780315845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubDMDM6wGspJnyNY0ZzFFo1/bXU2Y+EqKXd1zfPgBZI=;
	b=TopKDxc+5z4d4+9Jr3oK7CkATuCLm7aHccqoaoqVaTOUNHGkeYFMBWnhrVFLmRNVizUHfG
	or4Wg/UqZN4mkII8bHi6WGxbpN3sUHWeudVkj+u09Qf6J87U+kU7ArfF8vOneeCsk5TLm+
	mA2+0DQqFjlzrbXVIsznGHfLfNc8+XE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-U-uwmR_ROa-TbWXPzfJkQQ-1; Mon,
 01 Jun 2026 08:10:44 -0400
X-MC-Unique: U-uwmR_ROa-TbWXPzfJkQQ-1
X-Mimecast-MFC-AGG-ID: U-uwmR_ROa-TbWXPzfJkQQ_1780315843
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C09818005B8;
	Mon,  1 Jun 2026 12:10:43 +0000 (UTC)
Received: from ws (unknown [10.44.32.253])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A9D019560A2;
	Mon,  1 Jun 2026 12:10:41 +0000 (UTC)
Date: Mon, 1 Jun 2026 14:10:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: util-linux@vger.kernel.org, 
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: Re: [PATCH] include/mountutils.h: fix LSMT_ROOT definition
Message-ID: <ehtjxe4s2nqi6rqgstoelre27kh3xezvsqvaggascmutoicxdu@ohj5fmljs6r3>
References: <20260530094932.2351791-1-thomas.petazzoni@bootlin.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530094932.2351791-1-thomas.petazzoni@bootlin.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, May 30, 2026 at 11:49:32AM +0200, Thomas Petazzoni wrote:
>  #ifdef LSMT_ROOT
>  # define LSMT_ROOT ...
>  #endif
> 
> Should obviously have been:
> 
>  #ifndef LSMT_ROOT
>  # define LSMT_ROOT ...
>  #endif

Ah, nice. Applied (and also backported to stable/v2.42), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

