Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54024 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759164AbcAUJsf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jan 2016 04:48:35 -0500
Date: Thu, 21 Jan 2016 10:48:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        David =?utf-8?B?xaB0xJtyYmE=?= <dsterba@suse.cz>
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160121094833.67lg22o4la7j7pto@ws.net.home>
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A002B3.5090505@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 20, 2016 at 10:57:07PM +0100, Stanislav Brabec wrote:
> +/**
> + * btrfs_get_default_subvol_id:
> + * @path: Path to mounted btrfs volume

this comment formatting indicate API docs, for private library functions
we don't use "/**".

> + * Searches for the btrfs default subvolume id.
> + *
> + * Returns: default subvolume id or -1 in case of no default
> + * subvolume or error. In case of error, errno is set properly.
> + */
> +__u64 btrfs_get_default_subvol_id(const char *path)

Please, use standard userspace types, for example uint64_t. This is
generic rule, kernel-like types are unacceptable.

> +{
> +	int iocret;
> +	int fd;
> +	DIR *dirstream = NULL;
> +	struct btrfs_ioctl_search_args args;
> +	struct btrfs_ioctl_search_key *sk = &args.key;
> +	struct btrfs_ioctl_search_header *sh;
> +	__u64 found = (__u64)-1;

   = UINT64_MAX

> +struct btrfs_disk_key {
> +	__le64 objectid;
> +	__u8 type;
> +	__le64 offset;
> +} __attribute__ ((__packed__));
> +
> +struct btrfs_dir_item {
> +	struct btrfs_disk_key location;
> +	__le64 transid;
> +	__le16 data_len;
> +	__le16 name_len;
> +	__u8 type;
> +} __attribute__ ((__packed__));

again, use int64_t, uint8_t, etc.

>  /**
> + * mnt_table_find_target_with_option:
> + * @tb: tab pointer
> + * @path: mountpoint directory
> + * @option: option name (e.g "subvol", "subvolid", ...)
> + * @val: option value
> + * @direction: MNT_ITER_{FORWARD,BACKWARD}
> + *
> + * Try to lookup an entry in the given tab that matches combination of
> + * @path and @option. In difference to mnt_table_find_target(), only
> + * @path iteration is done. No lookup by device name, no canonicalization.
> + *
> + * Returns: a tab entry or NULL.
> + */

 if you want to export this function by API then it's necessary to add
 to libmount.h.in and libmount.sym, otherwise don't use "/**".

> -		DBG(TAB, ul_debug("setting FS root: btrfs subvol"));
> +		{
> +			/* If fstab entry does not contain "subvol", we have to
> +			 * check, whether btrfs has default subvolume
> +			 * defined. */
> +
> +			__u64 default_id;
> +			const char *target;
> +			char default_id_str[16]; /* should be safe for u64 */

   char default_id_str[sizeof(stringify_value(UINT64_MAX))];

> +
> +			default_id = btrfs_get_default_subvol_id(mnt_fs_get_target(fs));
> +			if (default_id == (__u64)-1)
> +				goto dflt;
> +
> +			/* Volume has default subvolume. Check if it
> +			 * matches to the one in mountinfo.
> +			 *
> +			 * Only kernel >= 4.2 reports subvolid. On older
> +			 * kernels, there is no reasonable way to detect which
> +			 * subvolume was mounted. */
> +			target = mnt_resolve_spec(mnt_fs_get_target(fs), tb->cache);
> +			snprintf(default_id_str, 16, "%llu", (unsigned long long int)default_id);

    snprintf(default_id_str, sizeof(default_id_str), ....


> +			DBG(TAB, ul_debug("target = %s subvolid = %s", target, &default_id_str));
> +			struct libmnt_fs *f = mnt_table_find_target_with_option(tb, target, "subvolid", default_id_str, MNT_ITER_BACKWARD);
> +			if (!f)
> +				goto dflt;
> +
> +			/* Instead of set of BACKREF queries constructing
> +			 * subvol path, use the one in mountinfo. Kernel does
> +			 * the evaluation for us. */
> +			DBG(TAB, ul_debug("setting FS root: btrfs default subvolid = %s", &default_id_str));
> +			if (mnt_fs_get_option(f, "subvol", &vol, &volsz))
> +				goto dflt;
> +		} else
> +			DBG(TAB, ul_debug("setting FS root: btrfs subvol"));

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
