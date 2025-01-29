Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590B18C31
	for <util-linux@vger.kernel.org>; Wed, 29 Jan 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152982; cv=none; b=KOMuKnoXx+Wsp1oh9kU1LJFT8VKdINbFL0Piz3sShhFIfMQvFFqpV/yMsbh3DWiGatHvIOU1lWW3RPCsxE/hiCju6wRFf7KZ0uPcb5aj42j7sR68sjQzv4t4e/lOdQ8/G9eIpUiKj+S2rUYsPL3/FgFhpt0CD6HaCn2BrPuWBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152982; c=relaxed/simple;
	bh=lFeYHSoFBM1G9yxnWnE7lO5zItM2TV6dTTcypneZtcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOAeHQ/8RLyg61Y8v7PzS2udbAeqnjfRfhdVA5twT6ryRrJOVg156VfvD1kmBa2ZAswBgwpRswXxF+/aE3IQaJdMcTSUx1AzMAQzrOn4WJD+d0krdv1cxgZO+4KyJUXmU2tUq1SNaujKuEAFPlRotwT3Ym09MSWNPdOm1COJoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnYzW0o6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnYzW0o6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738152980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4SDRBdhJ6vtBMDwACmHA7staPaO+nPO/EhI7CnOBvo=;
	b=JnYzW0o65tbmcA0q8Uhtz3FAdgk2an8rvR+NletC2XIbBXG8sQrRD9Ej+kfPF/PPZ1Wsy1
	GdWJ5wc1ipVgMLQ3dRJN5PzCCpYVtjYya0eFrPqsvvhx5IfP+i0mwX/e9Qgm3wisjNKdYX
	TqY04ezUU3Fhikp7D/6Pi4sQ0+kGTew=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-N3UZ6mmHPXePBYRq-x8gXw-1; Wed,
 29 Jan 2025 07:16:18 -0500
X-MC-Unique: N3UZ6mmHPXePBYRq-x8gXw-1
X-Mimecast-MFC-AGG-ID: N3UZ6mmHPXePBYRq-x8gXw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449FC1800373;
	Wed, 29 Jan 2025 12:16:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.106])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43DF71800955;
	Wed, 29 Jan 2025 12:16:16 +0000 (UTC)
Date: Wed, 29 Jan 2025 13:16:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Marc =?utf-8?Q?Aur=C3=A8le?= La France <tsi@tuyoix.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add setsid option to save child process id
Message-ID: <ez4oc4bocqcilq36ncfjusirdkmt6jkpfvaakrx5qcslzoqj6f@wxu57ze7zutk>
References: <be555f23-ae5e-f7d1-9b7c-28f4191664e7@tuyoix.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be555f23-ae5e-f7d1-9b7c-28f4191664e7@tuyoix.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


 Hi Marc,

On Sun, Jan 26, 2025 at 10:40:19AM GMT, Marc Aurèle La France wrote:
> Add an option to save the child's pid into a file.

we usually use Signed-off-by: line in the commit messages.

> @@ -105,6 +115,16 @@ int main(int argc, char **argv)
>  			break;
>  		default:
>  			/* parent */
> +			if (pidpath) {
> +				pidfile = fopen(pidpath, "w");
> +				if (pidfile == NULL)
> +					warn(_("cannot open pidfile %s"),
> +						pidpath);
> +				else {
> +					fprintf(pidfile, "%d\n", pid);
> +					fclose(pidfile);
> +				}
> +			}
>  			if (!status)
>  				return EXIT_SUCCESS;
>  			if (wait(&status) != pid)
 
What is the intended use-case for this feature?

I am unsure if this implementation is too simplistic. It seems that
the file is not deleted after the child process exits. Furthermore,
what would happen if we call multiple setsid instances with the same
pidfile? Would it be better to create the pidfile in the child process
after setsid() and ioctl(), in order to avoid creating the
pidfile in case of an error?

For reference, the code in misc-utils/uuidd.c uses a more advanced
method.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

