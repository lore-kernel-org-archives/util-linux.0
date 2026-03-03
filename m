Received: from hera.aquilenet.fr (hera.aquilenet.fr [185.233.100.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45981340DB9
	for <util-linux@vger.kernel.org>; Tue,  3 Mar 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.100.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543609; cv=none; b=bFNvo1ZMzeddVNmzB8rpoOUozfM182baY6i3uY/n0NwLwE3wFbz89p82cnRWX9LK7djZj7w2fVVKEFRB6FR+JJhVBzDXE5vH7GcaQWg4k8X8KFOPnUzpW2ythbjU64C4Ba4t9s/3odvmTNd/fN+1VvsAlH3D5oZ8thR2Yc9m9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543609; c=relaxed/simple;
	bh=hYhrZBaEtf0bwDc9/K2hJAfVpBM5L/QDwn+1Yn2Gmv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHSg6ydwXWJ+8MwqRNWeh5OnBRlVJ2IfjQogRRE3sq+XSSg8im6j7oARr2OZBndl7bev7y7twiSD8rwCdkZwJTTC5RLJ4aCeC14bER0bDzGF/XwBcSFES5Pn75cgP2jip8tSomGoYu3SELwtbnUNMPffOoNTNMLUJAd/a62Px2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquilenet.fr; spf=pass smtp.mailfrom=aquilenet.fr; dkim=pass (1024-bit key) header.d=aquilenet.fr header.i=@aquilenet.fr header.b=c04LFtEE; dkim=pass (1024-bit key) header.d=aquilenet.fr header.i=@aquilenet.fr header.b=cx981iP7; arc=none smtp.client-ip=185.233.100.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquilenet.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquilenet.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aquilenet.fr header.i=@aquilenet.fr header.b="c04LFtEE";
	dkim=pass (1024-bit key) header.d=aquilenet.fr header.i=@aquilenet.fr header.b="cx981iP7"
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id EA31717D;
	Tue,  3 Mar 2026 14:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquilenet.fr;
	s=dkim; t=1772543599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ7+G5aJ6cEjhtq22jJ4vSjHjCdFkc3E/JOdIM9PGRM=;
	b=c04LFtEEGYnn4nqxk4djxO3XTxkJgxvVk0C3opu8ur1/asdGz4pKQTNIJuVIbZo+V5D53g
	6v87JpfKDlOhP/5otj06C6T12V2wRvmnyY311Jj9oDow8sn13NdZSmaeETn8gcU58+boTr
	37s7/PlZDQxeIPiI8qEX7vepVVNod1o=
Authentication-Results: hera.aquilenet.fr;
	none
X-Virus-Scanned: Debian amavis at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxCec_mpFz6e; Tue,  3 Mar 2026 14:13:16 +0100 (CET)
Received: from end (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id A405D112;
	Tue,  3 Mar 2026 14:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquilenet.fr;
	s=dkim; t=1772543596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ7+G5aJ6cEjhtq22jJ4vSjHjCdFkc3E/JOdIM9PGRM=;
	b=cx981iP7epf2s3ZEdKZiScHo67N4UhHvLnBrTC/fwPdURA4zDv5l1OL7wTicY0IdcT51NG
	+8Yw1+C/8CLjlz9oxsUHOcYXDDGYDSU9xSXmdh1UxWsimGbJsTCAfv7yfG9zOcnzrJisaz
	ySqXAu18Qfs6u+wMDspxICJX8+ZIPF8=
Received: from samy by end with local (Exim 4.99.1)
	(envelope-from <samuel.thibault@aquilenet.fr>)
	id 1vxPYo-00000007E5U-3qSf;
	Tue, 03 Mar 2026 14:13:14 +0100
Date: Tue, 3 Mar 2026 14:13:14 +0100
From: Samuel Thibault <samuel.thibault@aquilenet.fr>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <aabealO6DscXLAKv@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
	Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <aaDlRkT-yYc87zpf@end>
 <agv5t6nkowhcpuw6iszi3bkwnxioqffp3ynmx7ronn5ycbegxe@kwibynxo6q6t>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agv5t6nkowhcpuw6iszi3bkwnxioqffp3ynmx7ronn5ycbegxe@kwibynxo6q6t>
Organization: I am not organized
X-Rspamd-Queue-Id: EA31717D
X-Spamd-Result: default: False [-2.50 / 15.00];
	NEURAL_HAM(-2.90)[-0.966];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[aquilenet.fr:s=dkim];
	RCVD_COUNT_THREE(0.00)[3];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[]
X-Rspamd-Action: no action
X-Spamd-Bar: --
X-Rspamd-Server: hera

Karel Zak, le mar. 03 mars 2026 12:46:57 +0100, a ecrit:
> On Fri, Feb 27, 2026 at 01:28:54AM +0100, Samuel Thibault wrote:
> > Here is a fix for non-linux systems.
> 
> Thanks. I made a small cleanup based on your suggestions.
> https://github.com/util-linux/util-linux/pull/4091

It builds fine, thanks!

Samuel
