Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48542 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbbLDOd4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 09:33:56 -0500
Date: Fri, 4 Dec 2015 15:32:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: Stanislav Brabec <sbrabec@suse.cz>,
        util-linux <util-linux@vger.kernel.org>,
        =?iso-8859-1?Q?S=F8ren?= Holm <sgh@sgh.dk>
Subject: Re: [PATCH] fix mount -a on btrfs bind mount
Message-ID: <20151204143204.GA27926@suse.cz>
Reply-To: dsterba@suse.cz
References: <56573D53.1020406@suse.cz>
 <56588FBD.9000502@suse.cz>
 <20151202125117.GJ4955@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151202125117.GJ4955@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 02, 2015 at 01:51:17PM +0100, Karel Zak wrote:
> On Fri, Nov 27, 2015 at 06:15:41PM +0100, Stanislav Brabec wrote:
> > root has to be literally the same as src_root, which is already the path
> > prefixed by /{subvolume}. Otherwise it will not match in
> > mnt_fs_streq_target(fs, xtgt) inside mnt_table_is_fs_mounted() and
> > repeated "mount -a" will mount it again and again.
> 
> yes
> 
> >  		if (src_root && !startswith(root, src_root)) {
> > -			size_t sz = strlen(root) + strlen(src_root) + 1;
> > -			char *tmp = malloc(sz);
> > -
> > +			char *tmp = strdup (src_root);
> >  			if (!tmp)
> >  				goto err;
> > -			snprintf(tmp, sz, "%s%s", src_root, root);
> >  			free(root);
> >  			root = tmp;
> >  		}
> 
> but this code is there for another use case. The problem is when the
> fstab_fs source is *sub-directory* on btrfs subvolume (or another bind
> mount). For example imagine:
> 
>   /dev/sdc        /mnt/test       btrfs   subvol=/anydir

Only subvolumes are accepted as parameter for 'subvol=', otherwise bind
mount needs to be used.
