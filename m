Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37658 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab2JOCHS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 22:07:18 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 05/13] ipcs: read shared memory values from /proc
Date: Sun, 14 Oct 2012 22:07:24 -0400
Cc: util-linux@vger.kernel.org
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi> <1350246145-10600-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4983759.iWXo6VqJHo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210142207.24981.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart4983759.iWXo6VqJHo
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sunday 14 October 2012 16:22:17 Sami Kerola wrote:
> +static int shmctl_info_wrapper(int maxid, int id, struct shm_data **shmds,
> +			       int use_proc)
> +{
> +	char skipheader[1024];
> +	int i, shmid;
> +	struct shm_data *shmdsp;
> +
> +	struct shmid_ds shmseg;
> +	struct ipc_perm *ipcp = &shmseg.shm_perm;
> +
> +	*shmds = xmalloc(sizeof(struct shm_data));
> +	shmdsp = *shmds;

could just one line:
	shmdsp = *shmds = xmalloc(sizeof(struct shm_data));

> +	shmdsp->next = NULL;
> +	if (use_proc) {
> +		FILE *f;
> +		if ((f = fopen(_PATH_PROC_IPCSHM, "r")) == NULL)
> +			return -1;

doesn't this leak memory with shmds ?

> +		fgets(skipheader, 1024, f);

why not just fseek() ?  does that not work on the /proc path ?

> +		for (i = 0; !feof(f); i++) {
> +			fscanf(f,
> +			       "%10d %10d  %4o " SIZE_SPEC
> +			       " %5lu %5lu  %5lu %5u %5u %5u %5u %10lu %10lu %10lu "
> +			       SIZE_SPEC " " SIZE_SPEC "\n",
> +			       &(shmdsp->shm_perm.key),
> +			       &(shmdsp->shm_perm.id),
> +			       &(shmdsp->shm_perm.mode),
> +			       &(shmdsp->shm_segsz),
> +			       &(shmdsp->shm_cprid),
> +			       &(shmdsp->shm_lprid),
> +			       &(shmdsp->shm_nattch),
> +			       &(shmdsp->shm_perm.uid),
> +			       &(shmdsp->shm_perm.gid),
> +			       &(shmdsp->shm_perm.cuid),
> +			       &(shmdsp->shm_perm.cgid),
> +			       &(shmdsp->shm_atim),
> +			       &(shmdsp->shm_dtim),
> +			       &(shmdsp->shm_ctim),
> +			       &(shmdsp->shm_rss),
> +			       &(shmdsp->shm_swp)
> +			    );

shouldn't this check the return of fscanf() ?

> -void do_shm (char format, int use_proc)
> +static void freeshms(struct shm_data *shmds)
>  {
> -	int maxid, shmid, id;
> -	struct shmid_ds shmseg;
> +	while (shmds) {
> +		struct shm_data *next = shmds->next;
> +		free(shmds);
> +		shmds = next;
> +	}
> +	return;
> +}

pointless return statement -> delete
-mike

--nextPart4983759.iWXo6VqJHo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQe2/cAAoJEEFjO5/oN/WB9cEP/1Efm6ozndUeHfdmlH8VYBF0
yVlZNaNBxO8u1zKaq+1a+OXW7iLZhxIibcZHS6TY3oazkiCeH0WLGVrm2nRm/aPJ
jvYvI7a65tzxuNvy9pj+Jrk/QSNV1oTPa/fnnSQ9EQoI1w37PDiMYvMCG3+RAltp
5Xyiwy6mLbAyFZPXfeJHlKB6V8m0GGpRg3388E7QgDcqTsZ5Pnzf5sASN/iXRqfP
TZ/NIuTBfN1oBS4XPAmYODYUpDfjadp+Rp72z+n4Dfdb26hlMGyp5tFyNjeidbWw
szXgYruEm9bIYf+3bJsH4yeLlJU3hA+NTJL9LziBLUrmvv5DOvLZy3gUJAIQ7/iT
P2so4tr9OW8iw9TyMrdT0uHa7xsD8OiiH2AXwiRVLYmoRv1qrQjcmekenPAJV25u
5rR8F6pD4zzCMQPw2f9zInsPrEzFl3wTs6ymrEFzRkgmJBCQsyBqrjkXYx4vpV1c
IBL37bNw9mezemCejd4CJu1UwQGKgcnMmV1o7qiWi3krQhI9+BX1JMeZsU2LohFq
imjwrgou6s7h7I8mn+Z5+pP/QT2HY9cTyX23BXv+/E5Z/5wO0vmHWOJ7F3omj8VV
iXE+mKUnkb83IPqYbrdAVksmXKDBkcYZkdDaTBJqZG8BdgUeZC5V0FFC2zOeQzXT
dXBK0WOl7w0/hvBb9cgC
=W80b
-----END PGP SIGNATURE-----

--nextPart4983759.iWXo6VqJHo--
