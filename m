Return-Path: <SRS0=oRo1=S3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22745C4321A
	for <util-linux@archiver.kernel.org>; Thu, 25 Apr 2019 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3478206BF
	for <util-linux@archiver.kernel.org>; Thu, 25 Apr 2019 18:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfDYSFD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:05:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37317 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbfDYSFC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 25 Apr 2019 14:05:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id e2so402114qtb.4
        for <util-linux@vger.kernel.org>; Thu, 25 Apr 2019 11:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ldpRpgCWBKKVSKykR5KEInYM/UNI+DvkAvjxNm2Zw14=;
        b=dduogFWD34MuQneMdgdNP7BRGa1Svf9ICZDrvuVwuodo28yWEs05Bcf1tkMJ+DVfZh
         QefniESCbHuJvdFSjEt1vUviEQyR0YfO66bFkWmCTvaVGypzUgF+WO7KpxiJhwN4JeS1
         PvLQI4q5QCpraCjSe1qPtUAl32blgvVYyDgg7lqacOfgBol7VZzLreqbeN8ouz2yVkmr
         u7d5K3J+PgSq0eMAejRbDdezAwkFNPG2PJ5YsFS0HhL1GFnUJxtPQgCY69rn76OLFmvQ
         CwthsT1EiJ7Sk4nNJ1xWSULHKvM2Pr6hgmU7uVexHVwd5aTVEpdXRpfqJHJol7uh46jz
         L4kA==
X-Gm-Message-State: APjAAAUK/m+MmrcNwtDBcCehX3+7uCcOcw/YXDWdTC7BY+9pKaWUrt4k
        ay1gTgMDEq2w8igr7bvKoqvOfg==
X-Google-Smtp-Source: APXvYqzoDHEQpSns9Vwp0vPL6e78OL526eJ6JFClUbLxmOT6IXuKkQYcOqV37yHkE0gskULGeAJHdw==
X-Received: by 2002:a0c:fe69:: with SMTP id b9mr6896606qvv.11.1556215501674;
        Thu, 25 Apr 2019 11:05:01 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-202A-0-0-0-83B.dyn6.twc.com. [2606:a000:1100:202a::83b])
        by smtp.gmail.com with ESMTPSA id w58sm10649429qtw.93.2019.04.25.11.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 11:05:01 -0700 (PDT)
Message-ID: <d26e7611f4e610bff81a16abbb88ca1c5ed70c91.camel@redhat.com>
Subject: Re: [PATCH 08/10] nfsd4: add file to display list of client's opens
From:   Jeff Layton <jlayton@redhat.com>
To:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, abe@purdue.edu,
        lsof-l@lists.purdue.edu, util-linux@vger.kernel.org
Date:   Thu, 25 Apr 2019 14:04:59 -0400
In-Reply-To: <1556201060-7947-9-git-send-email-bfields@redhat.com>
References: <1556201060-7947-1-git-send-email-bfields@redhat.com>
         <1556201060-7947-9-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 2019-04-25 at 10:04 -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Add a nfsd/clients/#/opens file to list some information about all the
> opens held by the given client.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 100 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 928705fc8ff5..829d1e5440d3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -684,7 +684,8 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
>  
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&cl->cl_lock);
> -	new_id = idr_alloc_cyclic(&cl->cl_stateids, stid, 0, 0, GFP_NOWAIT);
> +	/* Reserving 0 for start of file in nfsdfs "opens" file: */
> +	new_id = idr_alloc_cyclic(&cl->cl_stateids, stid, 1, 0, GFP_NOWAIT);
>  	spin_unlock(&cl->cl_lock);
>  	idr_preload_end();
>  	if (new_id < 0)
> @@ -2223,9 +2224,104 @@ static const struct file_operations client_info_fops = {
>  	.release	= single_release,
>  };
>  
> +static void *opens_start(struct seq_file *s, loff_t *pos)
> +	__acquires(&clp->cl_lock)
> +{
> +	struct nfs4_client *clp = s->private;
> +	unsigned long id = *pos;
> +	void *ret;
> +
> +	spin_lock(&clp->cl_lock);
> +	ret = idr_get_next_ul(&clp->cl_stateids, &id);
> +	*pos = id;
> +	return ret;
> +}
> +
> +static void *opens_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +	struct nfs4_client *clp = s->private;
> +	unsigned long id = *pos;
> +	void *ret;
> +
> +	id = *pos;
> +	id++;
> +	ret = idr_get_next_ul(&clp->cl_stateids, &id);
> +	*pos = id;
> +	return ret;
> +}
> +
> +static void opens_stop(struct seq_file *s, void *v)
> +	__releases(&clp->cl_lock)
> +{
> +	struct nfs4_client *clp = s->private;
> +
> +	spin_unlock(&clp->cl_lock);
> +}
> +
> +static int opens_show(struct seq_file *s, void *v)
> +{
> +	struct nfs4_stid *st = v;
> +	struct nfs4_ol_stateid *os;
> +	u64 stateid;
> +
> +	if (st->sc_type != NFS4_OPEN_STID)
> +		return 0; /* XXX: or SEQ_SKIP? */
> +	os = openlockstateid(st);
> +	/* XXX: get info about file, etc., here */
> +
> +	memcpy(&stateid, &st->sc_stateid, sizeof(stateid));
> +	seq_printf(s, "stateid: %llx\n", stateid);
> +	return 0;
> +}

More bikeshedding: should we have a "states" file instead of an "opens"
file and print a different set of output for each stateid type?

> +
> +static struct seq_operations opens_seq_ops = {
> +	.start = opens_start,
> +	.next = opens_next,
> +	.stop = opens_stop,
> +	.show = opens_show
> +};
> +
> +static int client_opens_open(struct inode *inode, struct file *file)
> +{
> +	struct nfsdfs_client *nc;
> +	struct seq_file *s;
> +	struct nfs4_client *clp;
> +	int ret;
> +
> +	nc = get_nfsdfs_client(inode);
> +	if (!nc)
> +		return -ENXIO;
> +	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
> +
> +	ret = seq_open(file, &opens_seq_ops);
> +	if (ret)
> +		return ret;
> +	s = file->private_data;
> +	s->private = clp;
> +	return 0;
> +}
> +
> +static int client_opens_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct nfs4_client *clp = m->private;
> +
> +	/* XXX: alternatively, we could get/drop in seq start/stop */
> +	drop_client(clp);
> +	return 0;
> +}
> +
> +static const struct file_operations client_opens_fops = {
> +	.open		= client_opens_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= client_opens_release,
> +};
> +
>  static const struct tree_descr client_files[] = {
>  	[0] = {"info", &client_info_fops, S_IRUSR},
> -	[1] = {""},
> +	[1] = {"open", &client_opens_fops, S_IRUSR},
> +	[2] = {""},
>  };
>  
>  static struct nfs4_client *create_client(struct xdr_netobj name,

-- 
Jeff Layton <jlayton@redhat.com>

