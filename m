Return-Path: lkml@tlinx.org
Message-ID: <5178CA1F.8010003@tlinx.org>
Date: Wed, 24 Apr 2013 23:15:59 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: mount --no-canonical seems broken.
References: <5175BA15.9060803@tlinx.org> <20130423123648.GB24501@x2.net.home> <517729C7.2030806@tlinx.org>
In-Reply-To: <517729C7.2030806@tlinx.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>





Linda Walsh wrote:
> Note -- I don't recall doing anything with mtab BEFORE -- BUT I may have
> made sure it was a separate file years ago when I started using lvm.
>
> Recently it was changed back to a symlink and on top of that -- whether
> it is a file or a symlink, mount doesn't seem to show the "non-canon" name
> (i.e. /dev/Vol/Log...)
> (though oddly enough -- "df" does!)..
>   

--------------
Note, to give an example of what is broken if you DO link /etc/mtab ->
/proc/self/mounts:
(from 'df''):


/dev/root                           12G  8.8G  3.3G  73% /
/dev/sdc6                           15G   10G  5.0G  67% /usr
/dev/sdc2                          7.8G  2.0G  5.9G  25% /var
/dev/sdc2                          7.8G  2.0G  5.9G  25% /tmp
/dev/sdc3                          908M  585M  323M  65% /boot
/dev/mapper/HnS-Share              1.5T  1.4T  153G  91% /Share
/dev/mapper/HnS-Home               1.0T  792G  233G  78% /home
/dev/mapper/HnS-Squid_Cache        128G   43G   86G  33% /var/cache/squid
/dev/mapper/Backups-Backups         11T  9.7T  1.3T  89% /backups
/dev/mapper/Media-Media            7.3T  6.4T  943G  88% /Media
/dev/HnS/Home-2013.03.29-21.00.11  1.5G  1.3G  208M  86%
/home/.snapdir/@GMT-2013.03.29-21.00.11
/dev/HnS/Home-2013.04.06-13.22.10  2.4G  2.1G  369M  85%
/home/.snapdir/@GMT-2013.04.06-13.22.10
/dev/HnS/Home-2013.04.08-05.07.04  1.2G 1008M  155M  87%
/home/.snapdir/@GMT-2013.04.08-05.07.04
/dev/HnS/Home-2013.04.10-05.07.03  1.2G  1.1G  160M  87%
/home/.snapdir/@GMT-2013.04.10-05.07.03
/dev/HnS/Home-2013.04.12-05.07.03  1.2G 1010M  153M  87%
/home/.snapdir/@GMT-2013.04.12-05.07.03
/dev/HnS/Home-2013.04.24-05.07.02  1.0T  792G  233G  78%
/home/.snapdir/@GMT-2013.04.24-05.07.02
/dev/HnS/Home-2013.04.16-05.07.03  8.1G  6.8G  1.3G  85%
/home/.snapdir/@GMT-2013.04.16-05.07.03

----
The only correct entries above are /dev/sdc? and the /dev/HnS/  lines, but
the last lines are correct as they are mounted by a script that mounts
the snapshot
and it uses no-canonicalize on mount.

The LVM volumes mounted at boot from /etc/fstab don't match the
names in fstab.

The output from mount is worse -- it has the last entries wrong as well --
even though no-canonicalize was specified on mount (as df shows),
mount shows:
/dev/mapper/HnS-Home--2013.03.29--21.00.11 on
/home/.snapdir/@GMT-2013.03.29-21.00.11 type xfs
(rw,relatime,attr2,inode64,logbsize=64k,sunit=128,swidth=1536,noquota)
/dev/mapper/HnS-Home--2013.04.06--13.22.10 on
/home/.snapdir/@GMT-2013.04.06-13.22.10 type xfs
(rw,relatime,attr2,inode64,logbsize=64k,sunit=128,swidth=1536,noquota)
/dev/mapper/HnS-Home--2013.04.08--05.07.04 on
/home/.snapdir/@GMT-2013.04.08-05.07.04 type xfs
(rw,relatime,attr2,inode64,logbsize=64k,sunit=128,swidth=1536,noquota)
/dev/mapper/HnS-Home--2013.04.10--05.07.03 on
/home/.snapdir/@GMT-2013.04.10-05.07.03 type xfs
(rw,relatime,attr2,inode64,logbsize=64k,sunit=128,swidth=1536,noquota)
/dev/mapper/HnS-Home--2013.04.12--05.07.03 on
/home/.snapdir/@GMT-2013.04.12-05.07.03 type xfs
(rw,relatime,attr2,inode64,logbsize=64k,sunit=128,swidth=1536,noquota)
/dev/mapper/HnS-Home--2013.04.24--05.07.02 on
/home/.snapdir/@GMT-2013.04.24-05.07.02 type xfs
(ro,relatime,nouuid,norecovery,attr2,inode64,logbsize=64k,sunit=128,swidth=1536,noquota)
/dev/mapper/HnS-Home--2013.04.16--05.07.03 on
/home/.snapdir/@GMT-2013.04.16-05.07.03 type xfs
(rw,relatime,attr2,inode64,logbsize=64k,sunit=128,swidth=1536,noquota)

If I use separate /etc/fstab && mtab, then running "mount -f
-no-canonicalize -a" will fix
all of the paths to match what is in /etc/fstab -- FOR 'df'' -- but not
for mount...
mount stays broken either way.
