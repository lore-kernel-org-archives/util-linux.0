Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778FEC433EF
	for <util-linux@archiver.kernel.org>; Tue,  5 Apr 2022 05:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiDEFoH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDEFoG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Apr 2022 01:44:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0199F6E781
        for <util-linux@vger.kernel.org>; Mon,  4 Apr 2022 22:42:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B59668AFE; Tue,  5 Apr 2022 07:42:05 +0200 (CEST)
Date:   Tue, 5 Apr 2022 07:42:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, util-linux@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH] nvme: add namespace paths links
Message-ID: <20220405054205.GA23466@lst.de>
References: <20220401092855.90652-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401092855.90652-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
> It is really annoying to always have to loop through the entire
> /sys/block directory just to find the namespace path links for
> a single namespace in libnvme/nvme-cli.
> So provide links to the namespace paths for efficient lookup.

I think having some form of links would be useful.  Quite a while ago
Thadeu looked into adding some form of relationship for lsblk and
friends.  Maybe it would be good to sync up and make sure whatever
links we are adding would be useful for all users?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c      | 3 +++
>  drivers/nvme/host/multipath.c | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f204c6f78b5b..df4d89aa061f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4054,6 +4054,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	if (!nvme_ns_head_multipath(ns->head))
>  		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
> +	else
> +		sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
> +				  ns->disk->disk_name);
>  	del_gendisk(ns->disk);
>  	blk_cleanup_queue(ns->queue);
>  
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7fc58e1f6b09..dc9a4018f90d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -801,6 +801,8 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>  
>  void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
> +	int ret;
> +
>  	if (nvme_ctrl_use_ana(ns->ctrl)) {
>  		struct nvme_ana_group_desc desc = {
>  			.grpid = id->anagrpid,
> @@ -831,6 +833,12 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>  		ns->head->disk->queue->nr_zones = ns->queue->nr_zones;
>  #endif
> +	ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
> +				&disk_to_dev(ns->disk)->kobj,
> +				ns->disk->disk_name);
> +	if (ret)
> +		dev_warn(ns->ctrl->device,
> +			 "failed to create namespace path link\n");
>  }
>  
>  void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
> -- 
> 2.29.2
---end quoted text---
