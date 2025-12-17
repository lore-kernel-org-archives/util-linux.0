Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695172C0F93
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996011; cv=none; b=F7EpLZr6HD8Pfyv5aNrlHEQOWv1gLlTKlMn53TSwm3Aj8nlFfUe6ebGUA5ql0TwGNOYFWfJ3bpUtu99gZiMaR/YmhmEi67NDs7ut6SKKLMqOqXCjpdy14M4te5zey2n2jU82Hx1K9pM++XfFVIhlNfXraWzGeIcj8Hc9YhRStI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996011; c=relaxed/simple;
	bh=YZMseI5b55RLwmoTMpeXRWBhrxkUYlOR+L+0cW83g3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXGsLyiDtQnKzobjv7BOGcqCwgMp9+aCzkflNeaI5UBDuNGgCvD3O07GBiRQqQ8DOAp16JTcntpGpXc1m88G9T2w5yTgtZ3YapHdblCa0haAxO3RPlo+US9ymjTmiAeWWLQ4yQwn7DPwsyNOLKKRFonAivdRdVMTcl4ul4du6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zsa/gPr5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zsa/gPr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765996004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB8PHeqzDlZtxYgYydG9ckgoKqOYrTnLJTYvL8FlctQ=;
	b=Zsa/gPr5QzCc/hrm+12KZm6yk/WPAoSl3EMUPlZRX4LBTn+No4sKv6oru/zpYNUrWAione
	RklokT864TIIaeUP1UWfXW+RWT06yE+z9ko7luE9lIzJA3/LhUBWxWaJQ1QyxnSXXAvR6Z
	ypJ+NVvtL3eXPKh6mJgfpRVC9NVIWp8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-5wr4iG5IPnKUzteH9K1z9w-1; Wed,
 17 Dec 2025 13:26:42 -0500
X-MC-Unique: 5wr4iG5IPnKUzteH9K1z9w-1
X-Mimecast-MFC-AGG-ID: 5wr4iG5IPnKUzteH9K1z9w_1765996002
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CA331956080
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 18:26:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 955E9180045B;
	Wed, 17 Dec 2025 18:26:41 +0000 (UTC)
Date: Wed, 17 Dec 2025 13:26:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] blkpr: add read-reservation command
Message-ID: <20251217182640.GA69951@fedora>
References: <20251211160956.1540114-1-stefanha@redhat.com>
 <20251211160956.1540114-4-stefanha@redhat.com>
 <ce5rsy5oycyuyfke6kcyrqokgim3cctjewhuv4gw2ptbkev7zh@ehw77wgurx7y>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UqdLrI4bjNWXaatj"
Content-Disposition: inline
In-Reply-To: <ce5rsy5oycyuyfke6kcyrqokgim3cctjewhuv4gw2ptbkev7zh@ehw77wgurx7y>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--UqdLrI4bjNWXaatj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:53:46AM +0100, Karel Zak wrote:
> On Thu, Dec 11, 2025 at 11:09:56AM -0500, Stefan Hajnoczi wrote:
> >=20
> > diff --git a/meson.build b/meson.build
> > index 47b43c2af..b759e992f 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -768,6 +768,9 @@ conf.set('HAVE_DECL_PR_REP_CAPACITY', have ? 1 : fa=
lse)
> >  have =3D cc.has_header_symbol('linux/pr.h', 'IOC_PR_READ_KEYS')
> >  conf.set('HAVE_DECL_IOC_PR_READ_KEYS', have ? 1 : false)
> > =20
> > +have =3D cc.has_header_symbol('linux/pr.h', 'IOC_PR_READ_RESERVATION')
> > +conf.set('HAVE_DECL_IOC_PR_READ_RESERVATION', have ? 1 : false)
>=20
> It seems you do not need to define HAVE_DECL_IOC_PR_READ_RESERVATION
> and care about this in meson.build or configure.ac.
>=20
> > +#if HAVE_DECL_IOC_PR_READ_RESERVATION
> > +	{IOC_PR_READ_RESERVATION, "read-reservation",
> > +	"  * read-reservation: This command shows the current reservation.\n"=
},
> > +#endif
>=20
> I think you can use directly
>=20
>         #ifdef IOC_PR_READ_RESERVATION
>=20
>         #endif
>=20
> as IOC_PR_READ_RESERVATION is macro in linux/pr.h

Will fix in v2.

Stefan

--UqdLrI4bjNWXaatj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlC9eAACgkQnKSrs4Gr
c8hP6Qf/SousEKmVK/B0JKJS9XeNxF8nC7+AtsduTy6M9JDk8EALoJ0+TX5CPsOy
k98wjPeDy3nxp2lNiRI9R4+v8LXQhraYzPYgse8r3Ox5/8ps2CDbVgZh0AMxL4gF
pkwNwP1WIfzHRf6KG/XosrqkY1hDl/SGF1+5qDxE+PIxsmOOvwMAzZCLlQahefk+
/GyKQhst9UGkL3Lb9X6rODwDQeNHDRscRezwvC0+4PKOwr1WYvc3sHAIeC1G7MVt
CvnIBRbV6UEuTPNTjLOzW07dzfgWfHUTqxbvzOneDHLeh14D0+i4+z/HJ4U3mjzP
MlwS/qJcmp5c0f2NjeD2NMkRnyWsbw==
=XrzC
-----END PGP SIGNATURE-----

--UqdLrI4bjNWXaatj--

