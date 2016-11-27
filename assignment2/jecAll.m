clear

%randSeed = 1;
%randn('state' , randSeed);
%rand('state' , randSeed);

corel_path = '/home/irshad/Course_Work/ML/Assignment1/corel5k.20091111/';
feats1 = struct('feats', {{'DenseHue', 'cityblock'}, {'DenseHueV3H1', 'cityblock'}, {'DenseSift', 'chisq'}, {'DenseSiftV3H1', 'chisq'}, {'Gist', 'euclidean'}, {'HarrisHue', 'cityblock'}, {'HarrisHueV3H1' 'cityblock'}, {'HarrisSift', 'chisq'}, {'HarrisSiftV3H1', 'chisq'}, {'Hsv', 'cityblock'}, {'HsvV3H1', 'cityblock'}, {'Lab', 'kld'}, {'LabV3H1', 'kld'}, {'Rgb', 'cityblock'}, {'RgbV3H1', 'cityblock'}});

trainAnnotations = vec_read('corel5k_train_annot.hvecs');
testAnnotations = vec_read('corel5k_test_annot.hvecs');

for i=1:15
    fd = feats1(i).feats;
    feat = cell2mat(fd(1))
    metric = cell2mat(fd(2))
    train = dir(strcat(corel_path, 'corel5k_train_', feat, '.*vec*'));
    test = dir(strcat(corel_path, 'corel5k_test_', feat, '.*vec*'));
    train = vec_read(train.name);
    test = vec_read(test.name);
    %{
    if strcmp(metric, 'chisq')
        %pairwise_distances = pdist2(train, test, @chisq);
        pairwise_distances = chisq(double(train), double(test));
    %}
    if strcmp(metric, 'kld')
        pairwise_distances = pdist2(train, test, 'cityblock');
    %else
    %    pairwise_distances = pdist2(train, test, metric);
    else
        continue
    end
    pairwise_distances(isnan(pairwise_distances)) = 0;
    mn = min(min(pairwise_distances));
    mx = max(max(pairwise_distances));
    norm_distances = (pairwise_distances -  mn) / (mx - mn);
    p = JEC(norm_distances, trainAnnotations, testAnnotations, 5);
    p
end