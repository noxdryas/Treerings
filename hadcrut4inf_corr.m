%hadcrut4infgs_corr
%ghcngs_corr
%compute correlations for MXD/ghcngs pairs
load('had4infa.mat'); load('had4infd.mat');
na = length(had4infa); nd = length(had4infd);


n = 0;
m = 0;
napairs = 0; naall = 0; nap1 = 0; nap2 = 0; 
nap12 = 0; nap1x2 = 0; napx12 = 0; napx1x2 = 0;
ndpairs = 0; ndall = 0; ndp1 = 0; ndp2 = 0; 
ndp12 = 0; ndp1x2 = 0; ndpx12 = 0; ndpx1x2 = 0;


for i = 1:na
    if had4infa(i).finalscreen == 7
        ind = ~isnan(had4infa(i).stdat) & ~isnan(had4infa(i).trdat);
        ind1 = ~isnan(had4infa(i).stdatp1) & ~isnan(had4infa(i).trdatp1);
        ind2 = ~isnan(had4infa(i).stdatp2) & ~isnan(had4infa(i).stdatp2);
        [had4infa(i).r, had4infa(i).signif, had4infa(i).p] = ...
            corr_sig(had4infa(i).stdat(ind), had4infa(i).trdat(ind));
        [had4infa(i).r1, had4infa(i).signif1, had4infa(i).p1] = ...
            corr_sig(had4infa(i).stdatp1(ind1), had4infa(i).trdatp1(ind1));
        [had4infa(i).r2, had4infa(i).signif2, had4infa(i).p2] = ...
            corr_sig(had4infa(i).stdatp2(ind2), had4infa(i).trdatp2(ind2));
    else
        m = m + 1;
    end
end
for i = 1:nd
    %had4infd(i).smtestcheck = had4infd(i).locscreen + had4infd(i).mindatsm + had4infd(i).timescreen;
if sum(~isnan(had4infd(i).stsm1)) > 15 & sum(~isnan(had4infd(i).stsm2)) > 10
	had4infd(i).smtestcheck = 4;
	else
had4infd(i).smtestcheck =0;
end
    
    if had4infd(i).smtestcheck == 4
        
        indsm = ~isnan(had4infd(i).stsm) & ~isnan(had4infd(i).trsm);
        indsm1 = ~isnan(had4infd(i).stsm1) & ~isnan(had4infd(i).trsm1);
        indsm2 = ~isnan(had4infd(i).stsm2) & ~isnan(had4infd(i).stsm2);
        
        
        [had4infd(i).smr, had4infd(i).smsignif, had4infd(i).smp] = ...
            corr_sig(had4infd(i).stsm(indsm), had4infd(i).trsm(indsm));
        [had4infd(i).smr1, had4infd(i).smsignif1, had4infd(i).smp1] = ...
            corr_sig(had4infd(i).stsm1(indsm1), had4infd(i).trsm1(indsm1));
        [had4infd(i).smr2, had4infd(i).smsignif2, had4infd(i).smp2] = ...
            corr_sig(had4infd(i).stsm2(indsm2), had4infd(i).trsm2(indsm2));
        
    else
        n=n+1;
    end
end

sprintf('%d annual records removed(quality control)', m)
sprintf('%d decadal records removed (quality control)', n)


save('had4infa.mat', 'had4infa')
save('had4infd.mat', 'had4infd')

for i = 1:na
    if had4infa(i).finalscreen == 7
        napairs = napairs + 1;
    end
    if had4infa(i).signif == 1
        naall = naall + 1;
    end
    if had4infa(i).signif1 == 1
        nap1 = nap1 + 1;
    end
    if had4infa(i).signif2 == 1
        nap2 = nap2 + 1;
    end
    if had4infa(i).signif1 == 1 & had4infa(i).signif2 == 1
        nap12 = nap12 + 1;
    end
    if had4infa(i).signif1 == 1 & had4infa(i).signif2 == 0
        nap1x2 = nap1x2 + 1;
    end
    if had4infa(i).signif1 == 0 & had4infa(i).signif2 == 1
        napx12 = napx12 + 1;
    end
    if had4infa(i).signif1 == 0 & had4infa(i).signif2 == 0
        napx1x2 = napx1x2 + 1;
    end
end

for i = 1:nd
    if had4infd(i).smtestcheck == 4
        ndpairs = ndpairs + 1;
    end
    if had4infd(i).smsignif == 1
        ndall = ndall + 1;
    end
    if had4infd(i).smsignif1 == 1
        ndp1 = ndp1 + 1;
    end
    if had4infd(i).smsignif2 == 1
        ndp2 = ndp2 + 1;
    end
    if had4infd(i).smsignif1 == 1 & had4infd(i).smsignif2 == 1
        ndp12 = ndp12 + 1;
    end
    if had4infd(i).smsignif1 == 1 & had4infd(i).smsignif2 == 0
        ndp1x2 = ndp1x2 + 1;
    end
    if had4infd(i).smsignif1 == 0 & had4infd(i).smsignif2 == 1
        ndpx12 = ndpx12 + 1;
    end
    if had4infd(i).smsignif1 == 0 & had4infd(i).smsignif2 == 0
        ndpx1x2 = ndpx1x2 + 1;
    end
end

save had4infa_results3rm napairs naall nap1 nap2 nap12 nap1x2 napx12 napx1x2
save had4infd_results3rm ndpairs ndall ndp1 ndp2 ndp12 ndp1x2 ndpx12 ndpx1x2



