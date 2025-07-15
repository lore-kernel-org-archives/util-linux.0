Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E117231A30
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571183; cv=none; b=nIWoq4dxImAkhrYyCVehDRKpP3lWhNpud/Gr9SKvh8GnN05YrE+63OInThqD5vYQanSF69npn4PFysuAo3HiX1WMfXuoGFvXYDrHVbu0Kspa4j04sWIEbTzf2nPCmvaein7iMLtQeR9evFO5kdrmiZiMkGqXs9XL3/oKouguVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571183; c=relaxed/simple;
	bh=4ocqvOML9AbzgUAw0CY1ZjxA3XEtNnHXGm3agOoc8aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2S02XyeJSkxBT2tnDdaXhgXrRfYM/UpVee88nbRL84gq3bmepVqIJXzHyObgd96HNq9lrrqoOEYUPkHmCedx90EcynkCLnSI7JkcQB1SQQM4GF8SjV9SGE7ABR4Adlha823f7ysJXSWClMaWnO2XZmO4U13D3N37/wL/2hyphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQOqYqal; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQOqYqal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752571180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TjsbB296ItE/XwT1uGNlnyqt8FMOsC/TaV4AuQh0o0=;
	b=EQOqYqalPn0QiOat1Sg/o2ySumP2y9KOOLQzqLMqHU5b8Guy9hXNfuZi9dRDBP9+zqn12t
	35tg+HKPfR+J2YLJlYE0tAfXz24bxW336886eXjnkiywQIYbRQlcgriCRJJaeFrm+6X55b
	8TQ4nL/RS13pHj+gr4CH2X4nwjXKW1o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-qDX_HNrnPO2qAsabZNHMyQ-1; Tue,
 15 Jul 2025 05:19:36 -0400
X-MC-Unique: qDX_HNrnPO2qAsabZNHMyQ-1
X-Mimecast-MFC-AGG-ID: qDX_HNrnPO2qAsabZNHMyQ_1752571176
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC8AC195608B;
	Tue, 15 Jul 2025 09:19:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.225])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FEFD1956094;
	Tue, 15 Jul 2025 09:19:34 +0000 (UTC)
Date: Tue, 15 Jul 2025 11:19:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Paul Benoit <paul@os.amperecomputing.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] lscpu-arm: Remove the "Ampere-1a" part.
Message-ID: <muus4f4qyxjt3af2nxjois2twuvbfnbf37glsyiptslb4orglf@rnvwiszoffgl>
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
 <20250711211648.53361-2-paul@os.amperecomputing.com>
 <crm5fcuper7bhu7iv7jbejf3rnowwo4tuwrjnutngta56dedgm@zajfg6nh2okx>
 <fb54d607-dccc-419f-b92c-7bc8514213a6@arm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb54d607-dccc-419f-b92c-7bc8514213a6@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jul 14, 2025 at 03:48:50PM -0500, Jeremy Linton wrote:
> On 7/14/25 7:16 AM, Karel Zak wrote:
> > On Fri, Jul 11, 2025 at 02:16:48PM -0700, Paul Benoit wrote:
> > > Remove the "Ampere-1a" part.  On newer Ampere Computing systems, the
> > > system/model name will be obtained from /sys/bus/soc/devices/soc0/machine,
> > > that is populated with the ARM SMC CC SOC_ID Name.
> > 
> > If I understand correctly, there are old systems without
> > /sys/.../soc0/machine, right? The change will remove Ampere-1a from
> > the lscpu output. This sounds backward incompatible.
> 
> Thats a good point, but as I understand it, Ampere hasn't been happy with
> the string that is there.

We can update the string to make them happy.

> If its OK to break whatever scripts/etc might depend on it at the moment,
> why not just update the string.
> 
> Then invert the check so that the /sys/bus entry is preferred?

I still do not understand how a per-CPU identifier can be replaced by  
one soc0 path. What if there is soc1, soc2, etc.?

Anyway, using /sys/bus as the primary source and the hardcoded id_part[]  
array as a fallback seems better than removing anything from id_part[]  
and relying on /sys/bus only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

